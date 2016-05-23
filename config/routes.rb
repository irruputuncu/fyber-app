Rails.application.routes.draw do

  root 'offers#index'

  post '/search' => 'offers#search', as: 'offers_search'

end
