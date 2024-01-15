module Application
  module Friendship
    module Repositories
      class FriendshipRepository
        def initialize(short_path_calc)
          @short_path_calc = short_path_calc
        end

        def fetch_degree(user_source, user_destine)
          # build up the relationship matrix
          friendships = ::Friendship.all.order(:user_source_id)

          graph = {}
          friendships.each do |friendship|
            graph[friendship.user_source_id] ||= {}
            graph[friendship.user_destine_id] ||= {} # All nodes must be included even when single direction
            graph[friendship.user_source_id][friendship.user_destine_id] = 1
          end

          graph_for_source = @short_path_calc.dijkstra(graph, user_source.id)

          Domain::FriendshipDegree.new(
            user_source,
            user_destine,
            graph_for_source[user_destine.id],
            graph_for_source
          )
        end
      end
    end
  end
end
