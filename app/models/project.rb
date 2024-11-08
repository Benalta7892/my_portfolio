class Project < ApplicationRecord
  belongs_to :user

  has_many :project_technologies, dependent: :destroy
  has_many :technologies, through: :project_technologies
  has_many :frontend_technologies, lambda {
    where(category: 'frontend')
  }, through: :project_technologies, source: :technology_item
  has_many :backend_technologies, lambda {
    where(category: 'backend')
  }, through: :project_technologies, source: :technology_item
  has_many :tools, -> { where(category: 'tools') }, through: :project_technologies, source: :technology_item
  has_many_attached :pictures

  validates :title, presence: true
  validates :description, presence: true

  serialize :features, coder: JSON
  # serialize :frontend_technologies, coder: JSON
  # serialize :backend_technologies, coder: JSON
  # serialize :tools, coder: JSON

  # validates :technologies, presence: true
  validates :link, presence: true
  validates :dev_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
end
