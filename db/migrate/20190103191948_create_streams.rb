class CreateStreams < ActiveRecord::Migration[5.2]
  def change
    create_table :streams do |t|
      t.date       :stream_day
      t.datetime   :stream_start
      t.datetime   :stream_end
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :streams, [:user_id, :stream_day]
  end
end