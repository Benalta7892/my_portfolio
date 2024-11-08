class DropFrontendTechnologiesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :frontend_technologies
  end
end
