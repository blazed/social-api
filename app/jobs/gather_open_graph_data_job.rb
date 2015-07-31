class GatherOpenGraphDataJob < ActiveJob::Base
  queue_as :http_service

  def perform(post_id, url, retry_count=1)
    post = Post.find(post_id)
    post.open_graph_cache = OpenGraphCache.find_or_create_by(url: url)
    post.save
  rescue ActiveRecord::RecordNotFound
    GatherOpenGraphDataJob.set(wait: 1.minute).perform_later(post_id, url, retry_count+1) unless retry_count > 3
  end
end
