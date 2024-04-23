class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @review = Review.find(params[:review_id])
    @canned_food = @review.canned_food
    @tags = @canned_food.tags
    
    # 削除されたページ数を計算し、現在のページ番号が削除範囲を超えている場合は修正する
    deleted_page = (@review.comments.count / 5.0).ceil
    if params[:page].to_i > deleted_page
      params[:page] = deleted_page.to_s
    end
    
    # 削除後にページネーションを更新
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
