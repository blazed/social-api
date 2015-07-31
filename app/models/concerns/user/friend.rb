require 'active_support/concern'

module Concerns
  module User
    module Friend
      extend ActiveSupport::Concern

      included do
        has_many :friendships
        has_many :friends, -> { order('users.first_name', 'users.last_name') }, class_name: 'User', through: :friendships
      end

      def can_request_friends?(user)
        user != self &&
        !friend?(user)
      end

      def friend?(user)
        friends.where('friendships.friend_id' => user.id).count > 0
      end
    end
  end
end

