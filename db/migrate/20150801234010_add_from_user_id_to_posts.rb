class AddFromUserIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :from_user_id, :uuid
  end
end
