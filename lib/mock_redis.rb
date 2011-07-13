require 'set'

require 'mock_redis/assertions'
require 'mock_redis/database'
require 'mock_redis/expire_wrapper'
require 'mock_redis/multi_db_wrapper'
require 'mock_redis/transaction_wrapper'
require 'mock_redis/undef_redis_methods'

class MockRedis
  include UndefRedisMethods

  def initialize(*args)
    @ds = TransactionWrapper.new(
      ExpireWrapper.new(
        MultiDbWrapper.new(
          Database.new(*args))))
  end

  def respond_to?(method, include_private=false)
    super || @ds.respond_to?(method, include_private)
  end

  def method_missing(method, *args)
    @ds.send(method, *args)
  end
end
