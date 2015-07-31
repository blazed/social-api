class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :name

  def name
    object
  end

end
