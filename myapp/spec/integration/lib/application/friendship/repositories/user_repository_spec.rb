require 'rails_helper'

RSpec.describe Application::Friendship::Repositories::UserRepository do
  describe 'fetch' do
    subject { Application::Friendship::Repositories::UserRepository.new }

    context 'when find the user' do
      let!(:user_model) { User.create(name: 'Estevao') }
      it "returns it" do
        user_domain = subject.fetch(user_model.id)

        # TODO: Refine the test to validate object build
        expect(user_domain.id).to eq(user_model.id)
      end
    end

    context 'when dont find the user' do
      it 'raises an exception' do
        # TODO: Make a custom exception to avoid leak db context
        expect { subject.fetch(321) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
