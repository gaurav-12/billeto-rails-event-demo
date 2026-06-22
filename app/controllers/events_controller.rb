class EventsController < ApplicationController
  include BilletoApi

  # INFO: Add :sync here in case you want to seed the data without authenticating from Clerk
  before_action :require_clerk_session!, except: [ :index ]
  before_action :set_event, only: [ :destroy, :upvote, :downvote ]
  before_action :set_user_vote, only: [ :upvote, :downvote ]
  after_action :emit_voting_event, only: [ :upvote, :downvote ]

  def index
    @events = Event.all
  end

  def destroy
    @event.destroy!

    respond_to do |format|
      format.html { redirect_to events_path, notice: "Event was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def sync
    response = sync_public_events
    if response["success"]
      render json: response, status: :ok
    else
      render json: response, status: :unprocessable_entity
    end
  end

  def upvote
    # TODO: Extract redundant logics of upvote and downvote to common method
    if @user_vote
      @user_vote.update!(upvote: true)
    else
      @user_vote = UserVote.new(user_id: clerk.user.id, event: @event, upvote: true)
      @user_vote.save!
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Successfully upvoted the event!" }
    end
  end

  def downvote
    if @user_vote
      @user_vote.update!(upvote: false)
    else
      @user_vote = UserVote.new(user_id: clerk.user.id, event: @event, upvote: false)
      @user_vote.save!
    end
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Successfully downvoted the event!" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_user_vote
      @user_vote = UserVote.find_by(user_id: clerk.user.id, event: @event)
    end

    def require_clerk_session!
      unless clerk.session
        respond_to do |format|
          # TODO: Configure redirect URL through environment variables
          format.html { redirect_to "#{clerk.sign_in_url}?redirect_url=http://localhost:3000", allow_other_host: true }
          format.json { render json: { error: "Unauthorized" }, status: :unauthorized }
        end
      end
    end

    def emit_voting_event
      stream_name = "event_#{@event.billeto_id}"
      event_name = (@user_vote.upvote ? "EventUpvoted" : "EventDownvoted").constantize
      event = event_name.new(data: { event_id: @event.billeto_id, upvote: @user_vote.upvote })

      # publishing an event for a specific stream
      Rails.configuration.event_store.tap do |store|
        store.publish(event, stream_name: stream_name)
      end
    end
end
