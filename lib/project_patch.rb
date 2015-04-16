module ProjectPatch
  def self.included(base)
    base.class_eval do
      # unloadable
      has_many :projects_jp_people
      has_many :jp_people, through: :projects_jp_people
    end
  end
end

Project.include ProjectPatch
