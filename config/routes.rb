Rails.application.routes.draw do
  root 'song_finder#index'
  get 'song_finder', to: 'song_finder#index'
  post 'song_finder', to: 'song_finder#create'
end