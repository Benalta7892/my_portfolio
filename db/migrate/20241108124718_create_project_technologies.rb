class CreateProjectTechnologies < ActiveRecord::Migration[7.1]
  def change
    create_table :project_technologies do |t|
      t.references :project, null: false, foreign_key: true
      t.references :technology_item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
