class AddToolsToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :tools, :text
  end
end
