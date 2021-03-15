class UsersController < ApplicationController
  def index
    @user = User.find(params[:id])
    @records = @user.records

    favorites = Favorite.where(user_id: current_user.id).pluck(:record_id)
    @favorite_list = Record.find(favorites)
  end
end
