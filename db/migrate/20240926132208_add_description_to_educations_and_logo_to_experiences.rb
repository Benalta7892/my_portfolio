class AddDescriptionToEducationsAndLogoToExperiences < ActiveRecord::Migration[7.1]
  def change
    add_column :educations, :description, :text
    add_column :experiences, :logo, :string
  end
end
