module Application
  module Friendship
    module Repositories
      class UserRepository
        def fetch(user_id)
          model = User.find(user_id)

          Domain::User.new(
            model.id,
            model.name
          )
        end
      end
    end
  end
end
