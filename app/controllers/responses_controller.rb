class ResponsesController < ApplicationController
  
  before_action :set_micropost, only: [:new, :create, :destroy]
  
  def new
    @response = @micropost.responses.new
  end
  
  def create
    @response = @micropost.responses.new(response_params)
    if @response.save && @response.update(comment_user_id: current_user.id)
      flash[:success] = "コメントが作成されました"
      redirect_to root_url
    else
      flash[:danger] = "コメントが作成できませんでした"
      render 'new'
    end
  end
  
  def destroy
    @response = @micropost.responses.find_by(params[:id])
    if @response.comment_user_id = current_user.id
      @response.destroy
      redirect_to request.referrer || root_url
    else
      redirect_to root_url
    end
  end
  
  private
  
    def response_params
      params[:response].permit(:content, :comment_user_id)
    end
    
    def set_micropost
      @micropost = Micropost.find(params[:micropost_id])
    end
end
