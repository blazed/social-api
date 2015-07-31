# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_id    :uuid
#  friend_id  :uuid
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_friend_id  (friend_id)
#  index_friendships_on_user_id    (user_id)
#

class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: 'User', foreign_key: 'friend_id'

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user_id }

  attr_accessor :skip_mirror

  before_create :mirror_friend

  def mirror_friend
    unless skip_mirror
      mirror = Friendship.new(user_id: friend_id)
      mirror.friend_id = user_id
      mirror.skip_mirror = true
      mirror.save!
    end
  end
end
