class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.date 			 :event_day
      t.datetime 	 :event_start
      t.datetime   :event_end
      t.string     :event_title
      t.text       :event_description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :events, [:user_id, :event_day, :event_start]
  end
end