class AddLocalLogoToTechnologyItems < ActiveRecord::Migration[7.1]
  def change
    add_column :technology_items, :local_logo, :string
  end
end
