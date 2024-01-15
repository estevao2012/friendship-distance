require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/friendships", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # Friendship. As you add validations to Friendship, be sure to
  # adjust the attributes here as well.
  #
  before(:all) do
    @user_source = User.create(name: 'Estevão')
    @user_destine = User.create(name: 'Cecilia')
  end

  let(:valid_attributes) {
    { user_source_id: @user_source.id, user_destine_id: @user_destine.id}
  }

  let(:invalid_attributes) {
    { user_source_id: 0, user_destine_id: 0}
  }

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Friendship" do
        expect {
          post friendships_url, params: { friendship: valid_attributes }
        }.to change(Friendship, :count).by(1)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Friendship" do
        expect {
          post friendships_url, params: { friendship: invalid_attributes }
        }.to change(Friendship, :count).by(0)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested friendship" do
      friendship = Friendship.create! valid_attributes
      expect {
        delete friendship_url(friendship)
      }.to change(Friendship, :count).by(-1)
    end
  end

  describe "GET /degree" do
    let!(:user_source_id) { User.create(name: 'Estevao').id }
    let!(:user_destine_id) { User.create(name: 'Cecilia').id }

    context 'when friendship degree exists' do
      before do
        Friendship.create(
          user_source_id: user_source_id,
          user_destine_id: user_destine_id
        )
      end

      it "fetches friendship separation degree" do
        get degree_friendships_url(format: :json), params: {
          friendship: {
            user_source_id: user_source_id,
            user_destine_id: user_destine_id
          }
        }

        relationship_degree = JSON.parse(response.body)

        expect(relationship_degree["degree"]).to eq(1)
      end
    end

    context 'when friendship degree dont exists' do
      it "fetches friendship separation degree" do
        get degree_friendships_url(format: :json), params: {
          friendship: {
            user_source_id: user_source_id,
            user_destine_id: user_destine_id
          }
        }
        expect(response.status).to eq(404)
      end
    end
  end
end
