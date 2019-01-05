class CreateStreams < ActiveRecord::Migration[5.2]
  def change
    create_table :streams do |t|
      t.date :day
      t.time :start_time
      t.time :end_time
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :streams, [:user_id, :day]
  end
end