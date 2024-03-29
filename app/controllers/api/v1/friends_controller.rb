class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @friend = User.find(params[:friend_id])
    @user.friendships.create!(friend: @friend)

    render json: @friend, status: 200
  end
end
