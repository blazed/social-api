class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.uuid :user_id, index: true
      t.uuid :friend_id, index: true

      t.timestamps null: false
    end
  end
end
