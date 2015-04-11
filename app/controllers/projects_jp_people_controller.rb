class ProjectsJpPeopleController < ApplicationController
  # unloadable
  def create
    @project_jp_person = ProjectsJpPerson.new(projects_jp_people_params)
    @person = @project_jp_person.jp_person
    if @project_jp_person.save
      @title = '情報'
      @msg = @project_jp_person.project.name + "を追加しました."
    else
      @title = 'エラー'
      @msg = @project_jp_person.project.name + "を追加できません."
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @project_jp_person = ProjectsJpPerson.find(params[:id])
    @project = @project_jp_person.project
    @project_jp_person.destroy
    redirect_to project_jp_people_path @project
  end

  private
  def projects_jp_people_params
    params.require(:projects_jp_person)
      .permit(:project_id, :jp_person_id, :pp_relationship, :is_project_owner)
  end
end
