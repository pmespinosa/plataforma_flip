Rails.application.routes.draw do

  # resources :questions do
  #   resources :homeworks
  #end

  resources :home
  devise_for :users
  resources :users

  post 'courses/new' => 'courses#agregate'
  post 'courses/:id/edit' => 'courses#edit'
  patch 'courses/:id/edit'=> 'courses#edit'
  get 'courses/:id/users'=> 'courses#students'

  get 'homework/:id/asistencia', to:'homeworks#asistencia', as:"homework_asistencia"
  post 'homework/:id/asistencia',to:'homeworks#asistencia'
  resources :courses do
    resources :users do
      resources :homeworks
    end
  end

  post  'homeworks/:id' => 'homeworks#change_phase'
  resources :homeworks do
    resources :questions do
      resources :answers
    end
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#home'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
