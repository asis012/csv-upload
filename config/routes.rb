Rails.application.routes.draw do
  root 'person#index'
  post 'person/import_csv', to: 'person#import_csv'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
