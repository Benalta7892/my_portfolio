class CreateTechnologyItems < ActiveRecord::Migration[7.1]
  def change
    create_table :technology_items do |t|
      t.string :name
      t.string :link
      t.string :category

      t.timestamps
    end
  end
end
