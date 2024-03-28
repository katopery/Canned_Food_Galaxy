class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @review = Review.find(params[:review_id])
    @canned_food = @review.canned_food
    @tags = @canned_food.tags
    
    @comments = @review.comments.page(params[:page]).per(5)
  end

  def destroy
    comment = Comment.find(params[:id])
    
    if comment.destroy
      flash[:notice] = "コメントを削除しました。"
      redirect_to request.referer
    else
      flash[:alert] = "コメントの削除が失敗しました。"
      render :index
    end
  end
end
