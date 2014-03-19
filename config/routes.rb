Rails.application.routes.draw do

  namespace :admin do
    get '/' => 'dashboard#index', ad: 'admin'
    resources :users do
      collection do
        get 'couponused'
      end
    end
    resources :coupons
  end

  namespace :fb do
    post 'create' => 'home#create'
    get 'index' => 'home#index'
    resources :users
  end
  
  namespace :pc do
    get 'index' => 'home#index'
    resources :users do
      collection do
        get 'delete'
      end
    end
  end
  
  namespace :mobile do
    get 'index' => 'home#index'
    get 'thank_you' => 'home#thank_you'
    get 'unique_error' => 'home#unique_error'
    get 'terms' => 'home#terms'
    get 'product' => 'home#product'
    resources :users
  end

  get 'web_switch' => 'web_switch#index'
  get 'fb_switch' => 'fb_switch#index'

  root 'web_switch#index'

  get "/:code", to:"coupons#show", contraints:{code: /[a-z]{5}-\d{4}/}, as: "coupon"
  get "/:code/edit", to:"coupons#edit", contraints:{code: /[a-z]{5}-\d{4}/}, as: "edit_coupon"
  put "/:code", to:"coupons#update", contraints:{code: /[a-z]{5}-\d{4}/}, as: "update_coupon"
  # resources :users
  devise_for :users
  resources :coupons, except: [:update, :edit, :show] do
  end
end
