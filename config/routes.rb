Rails.application.routes.draw do

  scope '/api' do

    

  end

  get '/'     => 'static#index'
  get '*path' => 'static#index'

end
