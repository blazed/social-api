class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, id: :uuid do |t|
      t.uuid :user_id, null: false
      t.boolean :public, default: false, null: false
      t.text :text
      t.integer :likes_count, default: 0
      t.integer :comments_count, default: 0

      t.timestamps null: false
    end
    add_index :posts, :user_id
  end
end
