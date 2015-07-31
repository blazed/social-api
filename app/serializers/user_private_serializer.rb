class UserPrivateSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :email, :photo_template

  has_many :notifications, limit: 2

  def photo_template
    object.photo.url(:small, false)
  end
end
