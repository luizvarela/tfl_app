redis = Redis.new(url: ENV['REDIS_URL'])

Cache.adapter = redis
