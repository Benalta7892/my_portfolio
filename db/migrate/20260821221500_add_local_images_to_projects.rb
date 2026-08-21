class AddLocalImagesToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :local_pictures, :json
    add_column :projects, :local_background_image, :string
  end
end
