class CreateResumes < ActiveRecord::Migration[7.1]
  def change
    create_table :resumes do |t|
      t.string :title
      t.text :description
      t.string :picture
      t.string :pdf
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end