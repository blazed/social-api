# == Schema Information
#
# Table name: notifications
#
#  id           :uuid             not null, primary key
#  recipient_id :uuid
#  target_id    :uuid
#  target_type  :string
#  unread       :boolean          default(TRUE)
#  type         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_notifications_on_recipient_id               (recipient_id)
#  index_notifications_on_target_type_and_target_id  (target_type,target_id)
#

class Notification < ActiveRecord::Base
  belongs_to :recipient, class_name: 'User'
  belongs_to :target, polymorphic: true

  private
  def self.types
    {
      "comment_on_post" => "Notifications:CommentOnPost"
    }
  end
end
