class AddOrderPositionToTechnologyItems < ActiveRecord::Migration[7.1]
  def change
    add_column :technology_items, :order_position, :integer
  end
end
