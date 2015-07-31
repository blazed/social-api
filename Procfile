web: bundle exec rails s -p ${PORT:="3000"}
worker: bundle exec sidekiq -q default -q http_service
s3: fakes3 -r ~/fakes3 -p 4567