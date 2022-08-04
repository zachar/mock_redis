class MockRedis
  module XInfoMethod

    def stream_info(key, group)
      with_stream_at(key) do |stream|
        { "length"=>stream.members.size,
          "radix-tree-keys"=>127,
          "radix-tree-nodes"=>271,
          "last-generated-id"=>members.last.id,
          "groups"=>stream.groups.size,
          "first-entry"=>
            [
              members.first.id,
              members.first.to_a
            ]
          ]
        }
      end
    rescue Redis::CommandError
      raise Redis::CommandError.new("Exception: ERR no such key")
    end

    def group_info(key, group)
      with_stream_at(key) do |stream|
        stream.groups.map do |group|
          {
            "name" => group.name,
            "consumers" => group.consumers.size,
            "pending" => group.pending,
            "last-delivered-id" => group.last_delivered_id
          }
        end  
      end
    end

    def consumers_info(key, group)
      debugger
      {
        consumers_info: 1
      }
      [{"name"=>"WEBHOOKS_PLANNER_01ae4f", "pending"=>191, "idle"=>180339046}, {"name"=>"WEBHOOKS_PLANNER_17d510", "pending"=>8, "idle"=>1035556828}, {"name"=>"WEBHOOKS_PLANNER_1af573", "pending"=>1, "idle"=>177385195}, {"name"=>"WEBHOOKS_PLANNER_2474df", "pending"=>1, "idle"=>1035519979}, {"name"=>"WEBHOOKS_PLANNER_2f498e", "pending"=>7, "idle"=>183041646}, {"name"=>"WEBHOOKS_PLANNER_3432bf", "pending"=>29, "idle"=>180774472}, {"name"=>"WEBHOOKS_PLANNER_45d138", "pending"=>1, "idle"=>177418000}, {"name"=>"WEBHOOKS_PLANNER_48be0a", "pending"=>4, "idle"=>1034784755}, {"name"=>"WEBHOOKS_PLANNER_4b8994", "pending"=>1, "idle"=>180265411}, {"name"=>"WEBHOOKS_PLANNER_590e34", "pending"=>10, "idle"=>178873273}, {"name"=>"WEBHOOKS_PLANNER_5b7569", "pending"=>272, "idle"=>177062037}, {"name"=>"WEBHOOKS_PLANNER_5c258a", "pending"=>37, "idle"=>180834521}, {"name"=>"WEBHOOKS_PLANNER_7cd8e2", "pending"=>49, "idle"=>177967360}, {"name"=>"WEBHOOKS_PLANNER_842e3a", "pending"=>1, "idle"=>177860040}, {"name"=>"WEBHOOKS_PLANNER_911d21", "pending"=>222, "idle"=>177089491}, {"name"=>"WEBHOOKS_PLANNER_ab8989", "pending"=>427, "idle"=>180912916}, {"name"=>"WEBHOOKS_PLANNER_b71f86", "pending"=>3, "idle"=>177200193}, {"name"=>"WEBHOOKS_PLANNER_b7cbaf", "pending"=>157, "idle"=>1034724350}, {"name"=>"WEBHOOKS_PLANNER_d00dc5", "pending"=>8, "idle"=>178832449}, {"name"=>"WEBHOOKS_PLANNER_f10ada", "pending"=>1, "idle"=>180304251}]      
    end

    def xinfo(subcommand, key, group=nil)
      debugger
      case subcommand.to_s.downcase
      when 'stream'; stream_info(key, group)
      when 'groups'; group_info(key, group)
      when 'consumers'; consumers_info(key, group)
      end
    end
  end
end
