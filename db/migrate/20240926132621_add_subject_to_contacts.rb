class AddSubjectToContacts < ActiveRecord::Migration[7.1]
  def change
    add_column :contacts, :subject, :string
  end
end
