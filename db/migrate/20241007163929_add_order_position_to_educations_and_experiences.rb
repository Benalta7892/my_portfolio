class AddOrderPositionToEducationsAndExperiences < ActiveRecord::Migration[7.1]
  def change
    add_column :educations, :order_position, :integer
    add_column :experiences, :order_position, :integer
  end
end
