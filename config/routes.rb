Socialmovie::Application.routes.draw do

  match "/movie/:id" => "movie#show", :via => :get, :as => :movie
  match "/search" => "movie#search", :via => :get, :as => :search

  match "/movie/listwatch/:id" => "movie#listwatch", :via => [:post]
  match "/movie/wantwatch/:id" => "movie#wantwatch", :via => [:post]
  
  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/:provider/callback" => "sessions#create"
  
  root :to => 'welcome#index'
  
end