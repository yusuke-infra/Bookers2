class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :is_logged_in?
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @user = User.find(current_user.id)
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
    
    def is_matching_login_user
      user = User.find(params[:id])
      # ログインユーザーでないなら、showページに飛ばす
      if !user_signed_in?
        redirect_to new_user_session_path
      elsif user.id != current_user.id
        redirect_to user_path(current_user.id)
      end
    end
    
    def is_logged_in?
      unless user_signed_in?
        redirect_to new_user_session_path
      end
    end
end
