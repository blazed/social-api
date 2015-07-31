# == Schema Information
#
# Table name: open_graph_caches
#
#  id           :integer          not null, primary key
#  title        :string
#  ob_type      :string
#  image        :string
#  url          :string
#  url_stripped :string
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe OpenGraphCache, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
