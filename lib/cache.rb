class Cache
  class << self
    attr_accessor :adapter

    def get(key)
      adapter.get(key)
    end

    def set(key, data)
      adapter.set(key, data)
    end
  end
end
