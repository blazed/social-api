class ApplicationController < ActionController::API
  include ActionController::Serialization

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
