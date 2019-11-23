Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :chords

  post '/chord', to: 'chords#create'
  post '/signup', to: 'users#create'
  post '/login', to: 'users#login'
  get '/user/chords', to: 'users#chords'

end
