module ProjectPatch
  def self.included(base)
    base.class_eval do
      # unloadable
      has_many :projects_jp_people
      has_many :jp_people, through: :projects_jp_people

      def org_name
        self[:name]
      end

      def name
        parent_id = project.parent.id if project.parent && Setting.plugin_redmine_jp_address['show_parent_project_owner']
        project_owners = ProjectsJpPerson.where(project_id: [project.id, parent_id], is_project_owner: true).joins(:jp_person).pluck(:name)
        if project_owners.present? && Setting.plugin_redmine_jp_address['show_project_owner']
          project_owners.join(',') + ' - ' + self[:name]
        else
          self[:name]
        end
      end
    end
  end
end

Project.include ProjectPatch
