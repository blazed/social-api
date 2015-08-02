class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  #include ActionController::ImplicitRender
  before_action :authenticate_user_from_token!

  private

  def authenticate_user_from_token!
    authenticate_with_http_token do |token, options|
      user_email = options[:email].presence
      user = user_email && User.find_by_email(user_email)

      if user && Devise.secure_compare(user.auth_token, token)
        request.env['devise.skip_trackable'] = true
        sign_in user, store: false
      end
    end
  end

  protected

  def authenticate_user!
    render(json: { errors: "Could not authenticate you" }, status: 401) unless current_user
  end

end
