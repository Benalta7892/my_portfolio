class CreateExperiences < ActiveRecord::Migration[7.1]
  def change
    create_table :experiences do |t|
      t.string :job_title
      t.string :company_name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.text :missions
      t.references :resume, null: false, foreign_key: true

      t.timestamps
    end
  end
end
