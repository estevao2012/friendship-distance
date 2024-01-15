require 'rails_helper'

RSpec.describe Application::Friendship::UseCases::CalculateSeparationDegree do
  describe 'perform' do
    subject(:use_case) {
      Application::Friendship::Api.calculate_separation_degree
    }

    let!(:user_source_id) { User.create(name: 'Estevao').id }
    let!(:user_destine_id) { User.create(name: 'Cecilia').id }

    context 'when relationship exists' do
      before do
        Friendship.create(
          user_source_id: user_source_id,
          user_destine_id: user_destine_id
        )
      end

      it "returns separation degree" do
        expect {
          use_case.perform(user_source_id, user_destine_id)
        }.not_to raise_error
      end
    end

    context 'when relationship dont exist' do
      it "raises UnreachableFriends exception" do
        expect {
          use_case.perform(user_source_id, user_destine_id)
        }.to raise_error(Application::Friendship::Errors::UnreachableFriends)
      end
    end
  end
end
