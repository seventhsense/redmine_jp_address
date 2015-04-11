require 'application_helper'

module ApplicationHelperPatch
  def link_to_project(project, options={}, html_options = nil)
    if project.archived?
      h(project.name)
    else
      project_owners = ProjectsJpPerson.where(project_id: project.id, is_project_owner: true)
      if project_owners.present? and Setting.plugin_redmine_jp_address['show_project_owner']
        link_title = "#{project_owners.map {|p| p.jp_person.name}.join(',')} - #{project.name}"
      else
        link_title = project.name
      end
      link_to link_title,
        project_url(project, {:only_path => true}.merge(options)),
        html_options
    end
  end

end


module ApplicationHelper
  prepend ApplicationHelperPatch
end
