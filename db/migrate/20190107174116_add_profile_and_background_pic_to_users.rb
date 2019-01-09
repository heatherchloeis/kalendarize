class AddProfileAndBackgroundPicToUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :profile_pic, 		:string
  	add_column :users, :background_pic, :string
  end
end
