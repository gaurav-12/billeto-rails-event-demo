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
    response = BilletoApi.sync_public_events
    format.json { render json: response, status: :ok}
    # TODO: Respond based on response if its error or success
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
