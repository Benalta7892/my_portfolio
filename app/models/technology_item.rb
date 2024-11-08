class TechnologyItem < ApplicationRecord
  has_one_attached :logo

  has_many :project_technologies, dependent: :destroy
  has_many :projects, through: :project_technologies

  validates :name, presence: true
  validates :category, presence: true

  enum category: { frontend: "frontend", backend: "backend", tools: "tools" }

  validates :order_position, uniqueness: { scope: :category, message: "La position doit être unique par catégorie." }
end
