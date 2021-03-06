class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :set_q, only: [:index, :search]

  def index
    @records = current_user.records.order("date DESC").page(params[:page]).per(10)
    @results = @q.result.order("date DESC")
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

  def show
  end

  def edit
  end

  def update
    @record.update(record_params)
    redirect_to root_path
  end

  def destroy
    @record.destroy
    redirect_to root_path
  end

  def search
    @results = @q.result.order("date DESC")
  end

  private

  def record_params
    params.require(:record).permit(:title, :category_id, :date, :place, :with, :text, :url, :status, images: []).merge(user_id: current_user.id)
  end

  def set_record
    @record = current_user.records.find(params[:id])
  end

  def set_q
    @q = current_user.records.ransack(params[:q])
  end

end
