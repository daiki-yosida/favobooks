class FavoritesController < ApplicationController
 before_action :require_user_logged_in
  
  def create
    book = Book.find(params[:book])
    current_user.add_favorite(book)
    flash[:success] = 'お気に入りに追加しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book = Book.find(params[:book])
    current_user.unfavorite(book)
    flash[:success] ='お気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
