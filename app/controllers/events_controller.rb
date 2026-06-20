class EventsController < ApplicationController
  before_action :set_event, only: [ :destroy, :upvote, :downvote]

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
    # TODO: Sync from API

    # respond_to do |format|
    #   if @event.save
    #     format.html { redirect_to @event, notice: "Event was successfully created." }
    #     format.json { render :show, status: :created, location: @event }
    #   else
    #     format.html { render :new, status: :unprocessable_content }
    #     format.json { render json: @event.errors, status: :unprocessable_content }
    #   end
    # end
  end

  def upvote
    # TODO: Implement it
  end

  def downvote
    # TODO: Implement it
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end
end
