class CreateProjectsJpPeople < ActiveRecord::Migration
  def change
    create_table :projects_jp_people do |t|
      t.integer :project_id
      t.integer :jp_person_id
      t.string :pp_relationship

      t.index :project_id
      t.index :jp_person_id
      t.index :pp_relationship
    end
  end
end
