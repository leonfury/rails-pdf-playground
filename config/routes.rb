Rails.application.routes.draw do
  resources :resumes
  
  root "resumes#index"
end
