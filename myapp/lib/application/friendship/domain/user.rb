module Application
  module Friendship
    module Domain
      class User
        attr_reader :id

        def initialize(id, name)
          @id = id
          @name = name
        end
      end
    end
  end
end
