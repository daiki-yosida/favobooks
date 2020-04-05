class BooksController < ApplicationController
  before_action :set_books, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def show
  end

  def new
    @book = current_user.books.build
  end

  def create
    @book = current_user.books.build(book_params)
    if @book.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
  end

  def update
    if @book.update(book_params)
      flash[:success] = '投稿は正常に更新されました'
      redirect_to @book
    else
      flash.now[:danger] = '投稿は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_to root_url
  end
  
  private
  
  def set_books
    @book = Book.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:comment, :title, :image)
  end
end
