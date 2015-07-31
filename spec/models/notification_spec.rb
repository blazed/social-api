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

require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
