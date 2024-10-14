class AddSubtitleToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :subtitle, :string
  end
end
