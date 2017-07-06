Rails.application.routes.draw do
  get 'disruptions' => 'disruptions#index'

  root 'pages#index'
end
