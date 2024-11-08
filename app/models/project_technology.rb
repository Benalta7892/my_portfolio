class ProjectTechnology < ApplicationRecord
  belongs_to :project, inverse_of: :project_technologies
  belongs_to :technology_item, inverse_of: :project_technologies
end
