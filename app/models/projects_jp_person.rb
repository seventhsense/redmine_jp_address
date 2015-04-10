class ProjectsJpPerson < ActiveRecord::Base
  # unloadable
  attr_accessible :project_id, :jp_person_id, :pp_relationship, :is_project_owner
  # relationship
  belongs_to :project
  belongs_to :jp_person

  #validation
  validates :project_id, uniqueness: {scope: :jp_person_id}
end
