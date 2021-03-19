class FavoritesController < ApplicationController
  before_action :set_record

  def create
    if @record.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, record_id: @record.id)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, record_id: @record.id)
    @favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def set_record
    @record = Record.find(params[:record_id])
  end
end
