class CreateEducations < ActiveRecord::Migration[7.1]
  def change
    create_table :educations do |t|
      t.string :diploma_name
      t.string :institution_name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.string :logo
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
