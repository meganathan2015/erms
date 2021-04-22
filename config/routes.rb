Rails.application.routes.draw do
  resources :policies
  resources :projects
  resources :attendances do 
    collection do
      get :approve_to_leave
      get :leave_to_approve
    end
  end

  resources :employee_timesheets
  resources :dashboards, only: [:index]
  devise_for :users
  # devise_for :users, :controllers => {registrations: 'registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'homes#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
