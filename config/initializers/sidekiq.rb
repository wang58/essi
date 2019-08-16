Sidekiq.options[:max_retries] = ESSI.config.fetch(:sidekiq,{}).fetch(:max_retries,nil) || 3
