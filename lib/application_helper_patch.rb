require 'application_helper'

module ApplicationHelperPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      # alias_method_chain :link_to_project, :product_owner
      def link_to_project(project, options={}, html_options = nil)
        if project.archived?
          h(project.name)
        else
          link_to 'hello',
            project_url(project, {:only_path => true}.merge(options)),
            html_options
        end
      end
    end
  end

  module ClassMethods
    
  end

  module InstanceMethods
    def link_to_project_with_product_owner(project, options={}, html_options = nil)
      if project.archived?
        h(project.name)
      else
        link_to 'hello',
          project_url(project, {:only_path => true}.merge(options)),
          html_options
      end
    end
  end

end

ApplicationHelper.send :include, ApplicationHelperPatch
