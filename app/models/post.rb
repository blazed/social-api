# == Schema Information
#
# Table name: posts
#
#  id                  :uuid             not null, primary key
#  user_id             :uuid             not null
#  public              :boolean          default(FALSE), not null
#  text                :text
#  likes_count         :integer          default(0)
#  comments_count      :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  open_graph_cache_id :integer
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :open_graph_cache

  validates :text, presence: true

  attr_accessor :open_graph_url

  after_commit :queue_gather_op_data, on: :create, if: :contains_open_graph_url_in_text?

  #after_create :push_post
  #after_create :update_pusher!
  #after_destroy :update_pusher!

  def raw_text
    read_attribute(:text)
  end

  def urls
    @urls ||= Twitter::Extractor.extract_urls(raw_text)
  end

  def queue_gather_op_data
    GatherOpenGraphDataJob.perform_later(self.id, self.open_graph_url)
  end

  def contains_open_graph_url_in_text?
    self.open_graph_url = self.urls[0]
  end

  def push_post
    Pusher.trigger('posts', 'push', PostSerializer.new(self).to_json)
  end

  #def send_push_notification
    #Pusher[]
  #end
end
