Rails.application.routes.draw do
  root 'home#new'
  post 'user/create' => 'api#createUser'
  post 'user/login' => 'api#login'
  get 'user/sign_out' => 'api#sign_out'
  post 'library/create' => 'library#create'
  post 'library/search' => 'library#search'
  get 'library/findall' => 'library#findAll'
  
end
