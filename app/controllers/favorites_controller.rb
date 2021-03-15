class FavoritesController < ApplicationController
  before_action :set_record

  def create
    if @record.user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, record_id: @record.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, record_id: @record.id)
    @favorite.destroy
  end

  private

  def set_record
    @record = Record.find(params[:record_id])
  end
end
