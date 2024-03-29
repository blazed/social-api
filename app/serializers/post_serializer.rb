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
#  from_user_id        :uuid
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#

class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :author,
             :text,
             :username,
             :open_graph_cache,
             :comments_count,
             :likes_count,
             :created_at,
             :updated_at,
             :photo,
             :user_id,
             :from_user_id,
             :type

  #has_one :user

  def author
    "#{object.from.first_name} #{object.from.last_name}"
  end

  def user_id
    object.user.id
  end

  def username
    object.from.username_lower
  end

  def photo
    object.from.photo.url('xsmall', false)
  end

  def type
    "post"
  end

end
