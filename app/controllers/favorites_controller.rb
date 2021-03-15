class FavoritesController < ApplicationController
  bofore_action :set_record

  def create
    if @record.user_id == current_user.index
      @favorite = Favorite.create(user_id: current_user.id, record_id: @record.id)
    end
  end

  private

  def set_record
    @record = Record.find(params[:record_id])
  end
end
