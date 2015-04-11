class JpPeopleController < ApplicationController
  # unloadable
  helper :sort
  include SortHelper
  model_object JpPerson
  before_action :set_person, only: [:show, :edit, :update, :destroy]
  before_action :set_project #, :only => [:index, :new, :create, :edit, :update] 

  def index
    @q ||= params[:q]
    sort_init 'jp_people.kana', 'desc'
    sort_update %w(jp_people.name jp_people.kana)
    @people = JpPerson.search_by_project_id(@project).search(@q).order(sort_clause)
    if @people.blank?
      @people = JpPerson.search_by_project_id(@project).phone_search(@q).order(sort_clause)
    end
    if @people.blank?
      @people = JpPerson.search_by_project_id(@project).mail_search(@q).order(sort_clause)
    end
    @limit = per_page_option
    @people_count = @people.count
    @person_pages = Paginator.new @people_count, @limit, params['page']
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @person = JpPerson.new
    @person.projects_jp_people.build(project_id: @project.id) unless @project == nil
  end

  def create
    @person = JpPerson.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, 
                      notice: t(:notice_create_person, name: @person.name) }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    if @project.present?
      @person.projects_jp_people.find_by(project_id: @project.id)
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person,
                      notice: t(:notice_update_person, name: @person.name) }
      else
        format.html { render :edit }
      end
    end
  end

  def add
    @query ||= ''
    @candidates = JpPerson.not_added(@project).search(@query).limit(8)
  end

  def add_people
    candidate_ids = params[:candidate][:id]
    candidate_ids.each do |id|
      @project.projects_jp_people.build(jp_person_id: id.to_i)
    end
    if @project.save!
      msg = '追加しました.'
    else
      msg = '追加できませんでした.'
    end
    redirect_to project_jp_people_path(@project),notice: msg 
  end

  def search_people
    @query = params[:query]
    @candidates = JpPerson.not_added(@project).search(@query).limit(8)
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @person.destroy
    return_url = @project.present? ? projects_jp_people_url : jp_people_url
    respond_to do |format|
      format.html { redirect_to return_url,
                    notice: t(:notice_destroy_person, name: @person.name) }
    end
  end

  def preview
    @text = params[:jp_person][:memo]
    render :partial => 'common/preview'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = JpPerson.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  rescue
    return
  end

  def set_project_from_assoc
    @project = @object.projects.find(params[:project_id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def person_params
    params.require(:jp_person)
      .permit(:name, :kana, :is_corporate, :represent, :represent_katagaki, :memo,
              jp_addresses_attributes: [:id, :label, :zip_code, :todofuken,
                                        :address1, :address2, :building, :corporate, :_destroy],
              jp_e_mails_attributes: [:id, :label, :mail_address, :_destroy],
              jp_phone_numbers_attributes: [:id, :label, :number, :_destroy],
              projects_jp_people_attributes: [:id, :project_id, :jp_people_id, :pp_relationship, :is_project_owner]
             )
  end

end
