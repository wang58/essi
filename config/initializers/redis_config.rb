require 'redis'
config = YAML.safe_load(ERB.new(IO.read(Rails.root.join('config', 'redis.yml'))).result, [], [], true)[Rails.env].with_indifferent_access
Redis.current = Redis.new(config.merge(thread_safe: true))

Sidekiq.configure_server do |c|
  c.redis = config
end

Sidekiq.configure_client do |c|
  c.redis = config
end
