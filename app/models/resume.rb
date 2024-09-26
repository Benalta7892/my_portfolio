class Resume < ApplicationRecord
  belongs_to :user

  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  validates :picture, presence: true
  validates :pdf, presence: true
end
