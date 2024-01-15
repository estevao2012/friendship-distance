class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ destroy ]
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  # POST /friendships or /friendships.json
  def create
    @friendship = Friendship.new(friendship_params)

    respond_to do |format|
      if @friendship.save
        format.json { render :show, status: :created, location: @friendship }
      else
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    @friendship.destroy!

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:user_source_id, :user_destine_id)
    end
end
