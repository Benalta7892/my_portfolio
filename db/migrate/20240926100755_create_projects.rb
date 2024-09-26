class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :pictures
      t.string :technologies
      t.integer :dev_count
      t.string :link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
