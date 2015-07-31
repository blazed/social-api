#require_dependency 'file_helper'

#BUCKET = AWS::S3.new.buckets['remote']

#class PullRemoteImagesJob < ActiveJob::Base
  #queue_as :http_service

  #def perform(*args)

    #open_graph_cache_id = args[:open_graph_cache_id]

    #open_graph_cache = OpenGraphCache.find(open_graph_cache_id)
    #return unless open_graph_cache.present?

    #remote = FileHelper.download(open_graph_cache.image, 'remote')
    #if remote
      #filename = File.basename(URI.parse(open_graph_cache.image).path)

      #open_graph_cache.image = upload.url
    #end
  #end
#end
