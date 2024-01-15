module Application
  module Friendship
    module Domain
      class FriendshipDegree
        attr_reader :degree, :steps

        def initialize(user_source, user_destine, degree, steps = {})
          @user_source = user_source
          @user_destine = user_destine
          @degree = degree ? degree : Float::INFINITY
          @steps = steps
        end

        def unreachable?
          @degree === Float::INFINITY
        end
      end
    end
  end
end
