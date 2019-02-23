Rails.application.routes.draw do
  resources :resumes

  mount Sidekiq::Web => '/sidekiq'

  post "/resumes/:id/download" => "resumes#download", as: "download"
  
  root "resumes#index"
end
