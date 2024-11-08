class RemoveCloudinaryUrlFromTechnologyItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :technology_items, :cloudinary_url, :string
  end
end
