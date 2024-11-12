class AddBackgroundImageToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :background_image, :string
  end
end
