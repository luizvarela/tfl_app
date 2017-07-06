require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  get 'disruptions' => 'disruptions#index'

  root 'pages#index'
end
