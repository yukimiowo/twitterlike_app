class ResponsesController < ApplicationController
  
  before_action :set_micropost, only: [:new, :create, :destroy]
  
  def new
    @response = @micropost.responses.new
  end
  
  def create
    @response = @micropost.responses.new(response_params)
    if @response.save
      flash[:success] = "コメントが作成されました"
      redirect_to root_url
    else
      flash.now[:danger] = "コメントが作成できませんでした"
      render 'new'
    end
  end
  
  def destroy
    @response = @micropost.responses.find_by(params[:id])
    if @response.user_id = current_user.id
      @response.destroy
      flash[:success] = "コメントが削除されました"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "コメントが削除できませんでした"
      redirect_to root_url
    end
  end
  
  private
  
    def response_params
      params.require(:response).permit(:content, :user_id)
    end
    
    def set_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end
end
