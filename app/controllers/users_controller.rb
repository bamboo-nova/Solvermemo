class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :codes, :followings, :followers]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    @codes = @user.codes.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def codes
    @user = User.find(params[:id])
    @codes = @user.codes.page(params[:page])
    counts(@user)
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.page(params[:page])
    @code_favorites = @user.code_favorites.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
