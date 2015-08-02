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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	#attr_accessor :login

  include Concerns::User::Friend

  has_many :posts, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id

  has_attached_file :photo, PAPERCLIP_PHOTO_OPTIONS
  has_attached_file :background, PAPERCLIP_BACKGROUND_OPTIONS

  validates :username, presence: true, length: { minimum: 3, maximum: 30 }, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9_.-]*\z/ }
  validates_exclusion_of :username, in: Settings.social.users.username_blacklist
  validates :first_name, presence: true
  validates :last_name, presence: true

  validates_attachment_size :photo, less_than: PAPERCLIP_PHOTO_MAX_SIZE
  validates_attachment_content_type :photo, content_type: PAPERCLIP_PHOTO_CONTENT_TYPES
  validates_attachment_size :background, less_than: PAPERCLIP_BACKGROUND_MAX_SIZE
  validates_attachment_content_type :background, content_type: PAPERCLIP_BACKGROUND_CONTENT_TYPES

  before_save :ensure_auth_token
  before_save :update_username_lower
  before_save :strip_downcase_email

  def update_username_lower
    self.username_lower = username.downcase
  end

  def strip_downcase_email
    if self.email
      self.email = self.email.strip
      self.email = self.email.downcase
    end
  end

  def self.find_by_username_or_email(username_or_email)
    if username_or_email.include?('@')
      find_by_email(username_or_email)
    else
      find_by_username(username_or_email)
    end
  end

  def self.find_by_email(email)
    find_by(email: email.downcase)
  end

  def self.find_by_username(username)
    find_by(username_lower: username.downcase)
  end

  #def self.find_for_database_authentication(warden_conditions)
    #conditions = warden_conditions.dup
    #if login = conditions.delete(:login)
      #where(conditions.to_hash).where(["lower(username_lower) = :value OR lower(email) = :value", { :value => login.downcase  }]).first
    #else
      #where(conditions.to_hash).first
    #end
  #end

  private

  def ensure_auth_token
    if self.auth_token.blank?
      self.auth_token = generate_auth_token
    end
  end

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.exists?(auth_token: token)
    end
  end

end
