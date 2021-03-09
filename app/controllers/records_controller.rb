class RecordsController < ApplicationController
  def index
    @records = Record.all.order("date DESC")
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.create(record_params)
    if @record.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def record_params
    params.require(:record).permit(:image, :title, :category_id, :date, :place, :with, :text, :url, :status).merge(user_id: current_user.id)
  end

end
