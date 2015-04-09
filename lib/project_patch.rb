require 'project'

module ProjectPatch
  def self.included(base)
    base.extend(ClassMethods)

    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable
      has_many :projects_jp_people
      has_many :jp_people, through: :projects_jp_people
    end
  end

  module ClassMethods
    
  end

  module InstanceMethods

  end

end

Project.include ProjectPatch
