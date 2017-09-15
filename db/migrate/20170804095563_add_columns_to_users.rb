class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
