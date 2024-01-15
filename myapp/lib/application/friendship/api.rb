module Application
  module Friendship
    module Api
      def self.calculate_separation_degree
        short_path_calc = Application::Friendship::Services::ShortPathCalculator.new
        user_repository = Application::Friendship::Repositories::UserRepository.new
        frienship_repository= Application::Friendship::Repositories::FriendshipRepository.new(short_path_calc)

        Application::Friendship::UseCases::CalculateSeparationDegree.new(
          user_repository,
          frienship_repository
        )
      end
    end
  end
end
