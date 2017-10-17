Rails.application.routes.draw do
  get 'request' => 'verify_auth#generate_request'
  post 'response' => 'verify_auth#handle_response'


  use_doorkeeper_openid_connect
  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root :to => "verify_auth#generate_request"
end
