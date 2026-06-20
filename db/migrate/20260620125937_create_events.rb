class CreateEvents < ActiveRecord::Migration[7.2]
  def change
    create_table :events do |t|
      t.string :billeto_id
      t.string :title
      t.string :description
      t.string :url
      t.string :image_link
      t.boolean :available
      t.string :organizer_name
      t.string :price
      t.string :currency
      t.string :category
      t.string :type
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
