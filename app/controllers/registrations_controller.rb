class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)
    if user.save
      data = {
        success: true,
        message: "You're account has been created. We sent an activation email to <strong>#{user.email}</strong>."
      }
      render json: { user: data }, status: 201
    else
      warden.custom_failure!
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password, :first_name, :last_name)
  end
end