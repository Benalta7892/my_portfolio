class Project < ApplicationRecord
  belongs_to :user

  has_many :project_technologies, dependent: :destroy
  has_many :technology_item, through: :project_technologies

  has_many :frontend_technologies,
           -> { where(category: 'frontend') },
           through: :project_technologies,
           source: :technology_item,
           inverse_of: :projects
  has_many :backend_technologies,
           -> { where(category: 'backend') },
           through: :project_technologies,
           source: :technology_item,
           inverse_of: :projects
  has_many :tools,
           -> { where(category: 'tools') },
           through: :project_technologies,
           source: :technology_item,
           inverse_of: :projects

  has_many_attached :pictures
  has_one_attached :background_image

  validates :title, presence: true
  validates :subtitle, presence: true
  validates :description, presence: true

  serialize :features, coder: JSON
  # serialize :frontend_technologies, coder: JSON
  # serialize :backend_technologies, coder: JSON
  # serialize :tools, coder: JSON

  # validates :technologies, presence: true
  validates :link, presence: true
  validates :dev_count, numericality: { only_integer: true, greater_than_or_equal_to: 1 }, presence: true
end
