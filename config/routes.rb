Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    constraints format: :json do
      get 'test' => 'robbot#test'
      post 'robot/0/orders' => 'robbot#create'
    end
  end
end
