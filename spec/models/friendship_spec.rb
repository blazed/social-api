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

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { Fabricate(:user) }
  let(:friend) { Fabricate(:user) }

  describe 'associtations' do
    it { should belong_to :user }
    it { should belong_to(:friend).class_name('User') }

    it 'should not allow duplicate friends' do
      expect { user.friendships.create! friend: friend }.to_not raise_error
      expect { friend.friendships.create! friend: user }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  it 'should make friend' do
    expect(user.friends.count).to eq(0)
    expect(friend.friends.count).to eq(0)
    user.friendships.create friend: friend
    expect(user.friends.count).to eq(1)
    expect(friend.friends.count).to eq(1)
  end

  context 'when #user is nil' do
    before do
      user.friendships.create friend: friend
      @friendship = user.friendships.first
      @friendship.user = nil
    end

    it 'should be invalid' do
      expect(@friendship).to be_invalid
    end
  end

  context 'when #friend is nil' do
    before do
      user.friendships.create friend: friend
      @friendship = user.friendships.first
      @friendship.friend = nil
    end

    it 'should be invalid' do
      expect(@friendship).to be_invalid
    end
  end
end
