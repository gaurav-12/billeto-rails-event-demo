class Event < ApplicationRecord
    has_many :user_votes

    validates :billeto_id, presence: true, uniqueness: true

    def upvotes
        user_votes.where(upvote: true).count
    end

    def downvotes
        user_votes.where(upvote: false).count
    end
end
