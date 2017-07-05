class MicropostsController < ApplicationController
  before_action :ensure_logged_in, only: [:create, :destroy]
  before_action :correct_micropost, only: :destroy
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "マイクロポストが作成されました"
      redirect_to root_url
    else
      flash.now[:danger] = "マイクロポストが作成できませんでした"
      @feed_items = current_user.feed.order(created_at: :DESC).paginate(page: params[:page])
      render 'static_pages/home'
    end
  end
  
  def destroy
    @micropost.destroy
    flash[:success] = "Micropostが削除されました"
    redirect_to request.referrer || root_url
  end
  
  private
  
    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end
    
    def correct_micropost
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
