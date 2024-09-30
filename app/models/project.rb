class Project < ApplicationRecord
  belongs_to :user
  has_many_attached :pictures

  validates :title, presence: true
  validates :description, presence: true
  # validates :pictures, presence: true

  validates :technologies, presence: true
  validates :link, presence: true
  validates :dev_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
end
