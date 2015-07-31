# == Schema Information
#
# Table name: users
#
#  id                      :uuid             not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  first_name              :string
#  last_name               :string
#  username                :string
#  username_lower          :string
#  photo_file_name         :string
#  photo_content_type      :string
#  photo_file_size         :integer
#  photo_updated_at        :datetime
#  background_file_name    :string
#  background_content_type :string
#  background_file_size    :integer
#  background_updated_at   :datetime
#  photo_fingerprint       :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :photo_template, :can_request_friend

  has_many :posts, include: false
  #has_many :friends, include: false

  def photo_template
    object.photo.url(:small, false)
  end

  def can_request_friend
    scope.can_request_friends?(object)
  end
end
