Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'job_postings#index'

  resources :job_postings
  resources :companies
end
