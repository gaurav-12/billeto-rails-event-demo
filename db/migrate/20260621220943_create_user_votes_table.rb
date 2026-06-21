class CreateUserVotesTable < ActiveRecord::Migration[7.2]
  def change
    create_table :user_votes do |t|
      t.string :user_id, null: false
      t.belongs_to :event
      t.boolean :upvote, default: false

      t.timestamps
    end
  end
end
