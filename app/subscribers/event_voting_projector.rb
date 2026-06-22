class EventVotingProjector
  def call(event)
    event_id = event.data[:event_id]
    event = Event.find_by(billeto_id: event_id)

    Turbo::StreamsChannel.broadcast_replace_to(
      "voting_count",
      target: "votes_#{event_id}",
      partial: "events/vote",
      locals: { upvotes:  event.upvotes, downvotes: event.downvotes, event: }
    )
  end
end
