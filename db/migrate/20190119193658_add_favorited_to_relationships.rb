class AddFavoritedToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :favorited, :boolean, default: false
  end
end
