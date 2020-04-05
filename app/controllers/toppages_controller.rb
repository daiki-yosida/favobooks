class ToppagesController < ApplicationController
  def index
    @books = Book.order(id: :desc).page(params[:page])
  end
end
