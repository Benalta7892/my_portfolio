class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :bio, :text
    add_column :users, :links, :string
    add_column :users, :avatar, :string
  end
end
