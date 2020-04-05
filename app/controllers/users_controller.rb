class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :likes, :followings, :followers]
  before_action :require_user_logged_in, only: [:imdex, :show, :edit, :update, :likes, :following, :followers]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
  end

  def show
    @books = @user.books.order(id: :desc).page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image = "default.jpg"
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'プロフィールは変更されました'
      redirect_to @user
    else
      flash[:danger] = '変更できませんでした'
      render :edit
    end
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
  end
  
  def likes
    @favorite_books = @user.favorite_books.page(params[:page])
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end

