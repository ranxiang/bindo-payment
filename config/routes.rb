Rails.application.routes.draw do
  get 'payslips/new'
  post 'payslips/create'

  root to: 'payslips#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
