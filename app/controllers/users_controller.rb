class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @records = @user.records.order("created_at DESC")

    favorites = Favorite.where(user_id: current_user.id).pluck(:record_id)
    @favorites = Record.find(favorites)
  end
end
