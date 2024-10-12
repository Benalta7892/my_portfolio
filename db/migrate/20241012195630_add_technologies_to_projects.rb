class AddTechnologiesToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :frontend_technologies, :text
    add_column :projects, :backend_technologies, :text
  end
end
