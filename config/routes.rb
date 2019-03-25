Rails.application.routes.draw do
  get '/new', to: 'games#new'
  post '/score', to: 'games#score'
  get '/end', to: 'games#end'
end
