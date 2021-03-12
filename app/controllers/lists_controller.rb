class ListsController < ApplicationController
  def index
    @records = Record.includes(:user).open.order("date DESC")
  end
end
