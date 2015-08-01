class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, expect: [:start_password_reset, :finish_password_reset]
  before_action :assert_reset_token_passed, only: [:finish_password_reset]
  skip_before_filter :verify_authenticity_token, only: [:start_password_reset]

  def me
    if current_user
      render json: current_user, status: 200, serializer: UserPrivateSerializer, root: 'user'
    end
  end

  def show
    user = User.find_by_username(params[:username])
    render json: user
  end

  def index
    if params[:ids]
      user = User.where(id: params[:ids])

      render json: user
    else
      users = User.all
      render json: users, each_serializer: UserSerializer
    end
  end

  def start_password_reset
    user = User.find_by_username_or_email(params[:login])
    user.send_reset_password_instructions if user

    render json: { status: 'ok' }, status: 200
  end

  def finish_password_reset
    user = User.with_reset_password_token(params[:reset_password_token])
    if user
      if user.reset_password(reset_params[:password], reset_params[:password])
        render json: { status: 'success' }, status: 200
      else
        render json: { errors: user.errors.full_messages }, status: 422
      end
    else
      render json: { errors: [{ message: 'Invalid password reset token' }] }, status: 403
    end
  end

  private

  def reset_params
    params.permit(:password)
  end

  def assert_reset_token_passed
    render json: { errors: [{ message: 'Empty reset token' }] }, status: 403 if params[:reset_password_token].blank?
  end
end
