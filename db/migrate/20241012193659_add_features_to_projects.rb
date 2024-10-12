class AddFeaturesToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :features, :text
  end
end
