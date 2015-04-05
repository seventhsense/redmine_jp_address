# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :jp_people, path: :address
match 'address/preview/(:id)' => 'jp_people#preview', as: :jp_people_preview, via: [:post, :patch, :put]
post 'addrsss/search' => 'jp_people#search', as: :jp_people_search
resources :projects do
  resources :jp_people, path: :address
end
resources :projects_jp_people
