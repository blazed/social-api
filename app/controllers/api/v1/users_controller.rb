class Api::V1::UsersController < ApplicationController
  #before_action :doorkeeper_authorize!

  def me
    if current_resource_owner
      render json: current_resource_owner, status: 200, serializer: UserPrivateSerializer, root: 'user'
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
end
