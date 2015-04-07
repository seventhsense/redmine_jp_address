# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :jp_people, path: :address
match 'address/preview/(:id)' => 'jp_people#preview', as: :jp_people_preview, via: [:post, :patch, :put]
# match 'addrsss/search' => 'jp_people#search', as: :jp_people_search, via:[:get, :post]
resources :projects do
  resources :jp_people, path: :address
end
resources :projects_jp_people
