class Contact < ApplicationRecord
  validates :last_name, :email, :message, presence: true
end
