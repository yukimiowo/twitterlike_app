class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user,  only: :destroy
  before_action :find_user, only: [:show, :destroy, :following, :followers]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def show
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ようこそ"
      redirect_to @user
    else
      flash.now[:error] = "作成に失敗しました"
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフールを更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "更新に失敗しました"
      render 'edit'
    end
  end
  
  def destroy
    if @user.destroy
      flash[:success] = "ユーザを削除しました"
      redirect_to users_url
    else
      #失敗時のアクション
      flash.now[:danger] = "削除に失敗しました"
      render 'index'
    end
  end
  
  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def find_user
      @user = User.find(params[:id])
    end
end
