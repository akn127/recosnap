class ListsController < ApplicationController
  def index
    @records = Record.includes(:user).open.order("date DESC")
  end

  def show
    @record = Record.find(params[:id])
  end
end
