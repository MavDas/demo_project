class AddIsPublicToGroups < ActiveRecord::Migration
  def change
  	add_column :groups, :is_public, :boolean, :default => false, :null => false
    add_index :groups, :is_public
  end
end
