require 'rails_helper'

RSpec.describe Application::Friendship::Repositories::FriendshipRepository do
  subject do
    Application::Friendship::Repositories::FriendshipRepository.new(
      Application::Friendship::Services::ShortPathCalculator.new
    )
  end

  describe 'fetch' do
    context 'when its a first degree separation' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        Friendship.create(
          user_source_id: user_source.id,
          user_destine_id: user_destine.id
        )
      end

      it "returns it" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(1)
      end
    end

    context 'when its a second degree separation' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        user_middleware = User.create(name: 'Middleware')

        Friendship.create(
          user_source_id: user_source.id,
          user_destine_id: user_middleware.id
        )

        Friendship.create(
          user_source_id: user_middleware.id,
          user_destine_id: user_destine.id
        )
      end

      it "returns it" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(2)
      end
    end

    context 'when its a third degree separation' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        user_middleware  = User.create(name: 'Middleware')
        user_middleware_sec  = User.create(name: 'Middleware Second')

        Friendship.create(
          user_source_id: user_source.id,
          user_destine_id: user_middleware.id
        )

        Friendship.create(
          user_source_id: user_middleware.id,
          user_destine_id: user_middleware_sec.id
        )

        Friendship.create(
          user_source_id: user_middleware_sec.id,
          user_destine_id: user_destine.id
        )
      end

      it "returns it" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(3)
      end
    end

    context 'when the source dont exists on graph' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        user_middleware  = User.create(name: 'Middleware')
        user_middleware_sec  = User.create(name: 'Middleware Second')

        Friendship.create(
          user_source_id: user_middleware.id,
          user_destine_id: user_middleware_sec.id
        )

        Friendship.create(
          user_source_id: user_middleware_sec.id,
          user_destine_id: user_destine.id
        )
      end

      it "returns infinity" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(Float::INFINITY)
      end
    end

    context 'when the destine dont exists on graph' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        user_middleware  = User.create(name: 'Middleware')
        user_middleware_sec  = User.create(name: 'Middleware Second')

        Friendship.create(
          user_source_id: user_source.id,
          user_destine_id: user_middleware.id
        )

        Friendship.create(
          user_source_id: user_middleware.id,
          user_destine_id: user_middleware_sec.id
        )
      end

      it "returns infinity" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(Float::INFINITY)
      end
    end

    context 'when the source and destine dont exists on graph' do
      let!(:user_source) do
        model = User.create(name: 'Estevao')
        Application::Friendship::Domain::User.new(
          model.id, 'Estevao'
        )
      end

      let!(:user_destine) do
        model = User.create(name: 'Cicero')
        Application::Friendship::Domain::User.new(
          model.id, 'Cicero'
        )
      end

      before do
        user_middleware  = User.create(name: 'Middleware')
        user_middleware_sec  = User.create(name: 'Middleware Second')

        Friendship.create(
          user_source_id: user_middleware.id,
          user_destine_id: user_middleware_sec.id
        )
      end

      it "returns infinity" do
        friendship_degree = subject.fetch_degree(user_source, user_destine)
        expect(friendship_degree.degree).to be(Float::INFINITY)
      end
    end
  end
end
