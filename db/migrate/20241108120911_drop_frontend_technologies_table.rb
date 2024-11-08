class DropFrontendTechnologiesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :frontend_technologies, if_exists: true
  end
end
