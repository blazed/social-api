class SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    data = {
      token: self.resource.auth_token,
      email: self.resource.email
    }
    render json: data, status: 201
  end

  def destroy
    sign_out :user
    render nothing: true
  end
end