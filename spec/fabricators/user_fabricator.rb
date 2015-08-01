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
#  auth_token              :string           default(""), not null
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
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

Fabricator(:user) do
  username { Faker::Internet.user_name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
end
