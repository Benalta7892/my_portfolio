class RemoveCloudinaryUrlFromTechnologyItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :technology_items, :cloudinary_url, :string, if_exists: true
  end
end
