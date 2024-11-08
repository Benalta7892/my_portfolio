class DropBackendTechnologiesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :backend_technologies
  end
end
