class Resume < ApplicationRecord
  belongs_to :user

  has_many :educations, dependent: :destroy
  has_many :experiences, dependent: :destroy

  has_one_attached :picture
  has_one_attached :pdf

  validates :title, presence: true
  validates :description, presence: true

  # validates :picture, presence: true
  # validates :pdf, presence: true
  serialize :description, JSON
end
