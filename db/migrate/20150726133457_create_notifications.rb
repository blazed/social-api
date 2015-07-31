class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications, id: :uuid do |t|
      t.references :recipient, index: true, type: :uuid#, foreign_key: true
      t.references :target, polymorphic: true, index: true, type: :uuid
      t.boolean :unread, default: true
      t.string :type

      t.timestamps null: false
    end
  end
end
