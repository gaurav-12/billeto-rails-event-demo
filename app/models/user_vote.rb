class UserVote < ApplicationRecord
    belongs_to :event

    validates :user_id, presence: true
end
