require 'rails_helper'

RSpec.describe Application::Friendship::UseCases::CalculateSeparationDegree do
  describe 'perform' do
    let(:frienship_repository) { double }
    let(:user_repository) { double }
    let(:use_case) {
      Application::Friendship::UseCases::CalculateSeparationDegree.new(
        user_repository,
        frienship_repository
      )
    }

    let(:friendship_degree) {
      Application::Friendship::Domain::FriendshipDegree.new(
        user_source,
        user_destine,
        2
      )
    }

    let(:user_source_id) { 1 }
    let(:user_destine_id) { 2 }
    let(:user_source) { Application::Friendship::Domain::User.new(user_source_id, 'Estevao') }
    let(:user_destine) { Application::Friendship::Domain::User.new(user_destine_id, 'Cecilia') }

    it "returns separation degree" do
      allow(user_repository).to receive(:fetch).with(user_source_id).and_return(user_source)
      allow(user_repository).to receive(:fetch).with(user_destine_id).and_return(user_destine)
      allow(frienship_repository).to receive(:fetch_degree).and_return(friendship_degree)
      result = use_case.perform(user_source_id, user_destine_id)
      expect(result).to eq friendship_degree
    end
  end
end
