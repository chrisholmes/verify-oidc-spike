require 'verify_service_provider'
class VerifyAuthController < ApplicationController
  skip_before_action :verify_authenticity_token
  def generate_request
    @verify_request = verify_service_provider.request
    if @verify_request.valid?
      session[:request_id] = @verify_request.id
      render :request
    else
      logger.error(@verify_request.message)
      render :request_error
    end
  end

  def handle_response
    @result = verify_service_provider.handle_response(params.fetch("SAMLResponse"), session[:request_id])
    if @result.valid?
      session[:user_pid] = @result.pid
      @user = User.find_by_pid(@result.pid)
      @user.sign_in!
      if session[:user_return_to]
        redirect_to(session[:user_return_to])
      else
        render :success_match
      end
    elsif @result.error?
      logger.error(@result.message)
      render :request_error
    else
      render :not_success_match
    end
  end

  def verify_service_provider
    @verify_service_provider ||= VerifyServiceProvider.new(ENV.fetch("VERIFY_SERVICE_PROVIDER_URL"))
  end
end
