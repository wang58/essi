Sidekiq.configure_server do |config|
  config.redis = { url: ESSI.config[:sidekiq][:url] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ESSI.config[:sidekiq][:url] }
end
