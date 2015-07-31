class AddPhotoFingerprintColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo_fingerprint, :string
  end
end
