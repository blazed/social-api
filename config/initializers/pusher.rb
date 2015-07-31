if Rails.env.production?
  Pusher.url = ENV['PUSHER_URL']
  Pusher.logger = Rails.logger
else
  Pusher.url = "https://91aa83336b2176ace66f:d9624e29747b41070875@api.pusherapp.com/apps/127125"
  Pusher.logger = Rails.logger

  if Rails.env.test?
    require 'pusher-fake/support/base'
  end
end