module Application
  module Friendship
    module UseCases
      class CalculateSeparationDegree
        def initialize(user_repository, frienship_repository)
          @user_repository = user_repository
          @friendship_repository = frienship_repository
        end

        def perform(user_source_id, user_destine_id)
          user_source = @user_repository.fetch(user_source_id)
          user_destine = @user_repository.fetch(user_destine_id)
          friendship_degree = @friendship_repository.fetch_degree(user_source, user_destine)

          raise Errors::UnreachableFriends if friendship_degree.unreachable?

          friendship_degree
        end
      end
    end
  end
end
