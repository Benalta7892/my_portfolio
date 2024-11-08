class DropToolsTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :tools, if_exists: true
  end
end
