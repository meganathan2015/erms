Rails.application.routes.draw do
  resources :policies
  resources :projects
  resources :reports 
  resources :home, only: [:index]
  resources :user_managements do
    collection do
      post :add_data_user_mgmnt
      get :new_user_mgmnt
      get :user_list
      post :upload_profile_image 
      get ":id/edit_user" => "user_managements#edit_user", :as => 'edit_user'
      put ":id/update_user" => "user_managements#update_user", :as => 'update_user' 
      delete ":id/delete_user" => "user_managements#delete_user", :as => 'delete_user' 
      get ":id/active_user_update" => "user_managements#active_user_update", :as => 'active_user_update' 
      get ":id/edit_password_user" => "user_managements#edit_password_user", :as => 'edit_password_user'
      put ":id/change_password_user" => "user_managements#change_password_user", :as => 'change_password_user'
      get ":id/edit_photo_user" => "user_managements#edit_photo_user", :as => 'edit_photo_user'
    end
  end


  resources :attendances do 
    collection do
      get :approve_to_leave
      get :leave_to_approve
    end
  end

  resources :employee_timesheets do 
    collection do 
      post :employee_retrieve_data
    end
  end
  resources :dashboards, only: [:index]
  devise_for :users
  # devise_for :users, :controllers => {registrations: 'registrations'}

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_scope :user do
    authenticated :user do
      root 'welcome#index', as: :authenticated_root
    end
  
    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
