Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'land#land'
  get '/trial', to: 'land#gold'
  get '/wager', to: 'wager#index'
  get '/wager/bus', to: 'wager#bus'
  get '/wager/pay', to: 'wager#pay'
  get '/wager/:id/bet', to: 'wager#bet'
  post '/wager/get_bus', to: 'wager#get_bus'
  get '/wager/new', to: 'wager#new'

  #NOTE: Change this back to 'wager#type' when we have the Type form.
  get '/wager/type', to: 'wager#type'
  get '/shop', to: 'shop#index'
  post '/wager/:id/under', to: 'wager#under'
  post '/wager/:id/over', to: 'wager#over'
end
