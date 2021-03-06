Redmine::Plugin.register :redmine_jp_address do
  name 'Redmine JP Address'
  author 'Seventh'
  description '日本向けのアドレス帳'
  version '0.6.2'
  url 'https://github.com/seventhsense/redmine_jp_address'
  author_url 'http://blog.scimpr.com'

  require_dependency 'project_patch'

  settings :default => {
    'empty' => true
  }, partial: 'settings/jp_address_settings'

  menu :top_menu, :redmine_jp_address, {
    :controller => 'jp_people', :action => 'index', project_id: nil 
  },
    :caption => 'アドレス帳',
    :if => Proc.new { User.current.logged? }
  permission :view_jp_people, jp_people: [:index, :show]
  permission :edit_jp_people, jp_people: [:edit, :destroy]

  menu :project_menu, :jp_people, { 
    controller: 'jp_people', action: 'index' 
  },
    :caption => 'アドレス帳', after: :activity, param: :project_id
  project_module :jp_people do
    permission :view_jp_people, jp_people: [:index, :show]
    permission :edit_jp_people, jp_people: [:create, :edit, :destroy]
  end

  # Redmine::Search::available_search_types << 'jp_people'
end
