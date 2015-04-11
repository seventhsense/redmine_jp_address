# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :jp_people, path: :address
match 'address/preview/(:id)' => 'jp_people#preview', as: :jp_people_preview, via: [:post, :patch, :put]
# match 'addrsss/search' => 'jp_people#search', as: :jp_people_search, via:[:get, :post]
resources :projects do
  get 'address/add' => 'jp_people#add'
  post 'address/search_people' => 'jp_people#search_people'
  post 'address/add_people' => 'jp_people#add_people'
  resources :jp_people, path: :address
end
resources :projects_jp_people
