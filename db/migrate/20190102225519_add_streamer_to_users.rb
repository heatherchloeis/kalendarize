class AddStreamerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :streamer, :boolean, default: false
  end
end