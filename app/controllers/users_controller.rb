class UsersController < ApplicationController

  allow_unauthenticated_access only: [:new, :create]

  before_action :is_matching_login_user, only: [:edit, :update]
  
  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to user_path(@user), notice: "ユーザ登録が完了しました！続けてログインしてください。"

      else
      
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users= User.all
    @user = Current.user
    @book = Book.new
    
  end

  def show
    @user = User.find(params[:id]) # 詳細を見たいユーザー
    @books = @user.books           # そのユーザーが投稿した本の一覧
    @book = Book.new
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "ユーザー情報を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end
 
  private
 
  def user_params
    
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == Current.user.id
      redirect_to user_path(Current.user)
    end
  end
end
