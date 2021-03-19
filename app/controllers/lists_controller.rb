class ListsController < ApplicationController
  def index
    @records = Record.includes(:user).open.order("date DESC").page(params[:page]).per(10)
  end

  def show
    @record = Record.find(params[:id])
  end
end
