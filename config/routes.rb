Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'landing#land'
  get '/wager/bus', to: 'wager#bus'
  get '/wager/pay', to: 'wager#pay'
  get '/wager/:id/bet', to: 'wager#bet'
  post '/wager/get_bus', to: 'wager#get_bus'
  get '/wager/new', to: 'wager#new'
  get '/wager/type', to: 'wager#type'
end
