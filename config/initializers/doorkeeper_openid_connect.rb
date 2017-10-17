Doorkeeper::OpenidConnect.configure do
  issuer 'http://localhost:3000'

  signing_key ENV.fetch('PROXY_PRIVATE_KEY')
  subject_types_supported [:public]

  resource_owner_from_access_token do |access_token|
    User.find_by(id: access_token.resource_owner_id)
  end

  auth_time_from_resource_owner do |resource_owner|
    resource_owner.last_sign_in_at
  end

  reauthenticate_resource_owner do |resource_owner, return_to|
    reset_session
    session[:user_return_to] = request.fullpath
    redirect_to(request_url)
  end

  subject do |resource_owner, application|
    # Example implementation:
    resource_owner.nhs_number

    # or if you need pairwise subject identifier, implement like below:
    # Digest::SHA256.hexdigest("#{resource_owner.id}#{URI.parse(application.redirect_uri).host}#{'your_secret_salt'}")
  end

  # Protocol to use when generating URIs for the discovery endpoint,
  # for example if you also use HTTPS in development
  # protocol do
  #   :https
  # end

  # Expiration time on or after which the ID Token MUST NOT be accepted for processing. (default 120 seconds).
  # expiration 600

  # Example claims:
  claims do
    claim :given_name, scope: :openid do |resource_owner|
      resource_owner.first_name
    end

    claim :family_name, scope: :openid do |resource_owner|
      resource_owner.last_name
    end

    claim :nhs_number, scope: :openid do |resource_owner|
      resource_owner.nhs_number
    end
  end
end
