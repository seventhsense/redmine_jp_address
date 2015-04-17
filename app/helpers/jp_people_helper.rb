module JpPeopleHelper
  TODOFUKEN = JpPrefecture::Prefecture.all.map{|p| p.name}
  def todofuken_name
    TODOFUKEN << 'その他'
  end

  def render_projects_jp_people(person)
    # logger.debug person
    render partial: 'projects_jp_people/index_table', :locals => {person: person}
  end
end
