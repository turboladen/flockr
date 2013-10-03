Flockr::Application.routes.draw do
  root 'home#index'

  resources :sessions, only: %i[new create destroy]
  get '/sign_up' => 'users#new'
  get '/sign_in' => 'sessions#new'
  delete '/sign_out' => 'sessions#destroy'

  resources :users do
    resources :photos do
      resources :comments, only: %i[new create edit update destroy]
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, except: %i[new edit] do
        resources :photos, except: %i[index new edit] do
          resources :comments, only: %i[create show update destroy]
        end
      end

      match '*foo', via: :all, constraints: { format: :json }, to: lambda { |env|
        # env here is the Rack env hash that contains all kinds of fun info.
        error = {
          'error' => "Route for '#{env['REQUEST_METHOD']} #{env['REQUEST_URI']}' not found"
        }

        # Notice that this is a return value in the format that Rack wants...
        [404, {}, [error.to_json]]
      }
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
