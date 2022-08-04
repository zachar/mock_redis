class MockRedis
  class Stream
    class Group
      def initialize(group)
        @name = group
        @consumers = Set.new
        @last_delivered_id = "0-0"

        @pending_entries_list = Set.new
      end

      def pending
        @pending_entries_list.size
      end

      def to_hash
        {
          "name" => @name,
          "consumers" => @consumers.size,
          "pending" => @pending,
          "last-delivered-id" => @last_delivered_id
        }
      end
    end
  end
end
