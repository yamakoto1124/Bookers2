class UsersController < ApplicationController

  allow_unauthenticated_access only: [:new, :create]
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
    @user = User.all
    
  end

  def show
    
  end
 
  private
 
  def user_params
    
    params.require(:user).permit(:name, :email_address, :password, :password_confirmation)
  end
end
