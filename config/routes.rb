Rails.application.routes.draw do

  scope '/api' do

    resources :parties
    resources :meals
    resources :guests

  end

  get '/'     => 'static#index'
  get '*path' => 'static#index'

end
