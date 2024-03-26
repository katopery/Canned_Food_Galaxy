class Public::CommentsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:create, :destroy]
  
  def create
    review = Review.find(params[:review_id])
    comment = current_member.comments.new(comment_params)
    comment.review_id = review.id
    
    if comment.save
      # コメントの保存が成功した場合の処理
      redirect_to request.referer
    else
      # コメントの保存が失敗した場合の処理
      flash[:alert] = "コメントの送信に失敗しました。"
      redirect_to request.referer
    end
  end

  def index
    @review = Review.find(params[:review_id])
    @canned_food = @review.canned_food
    @tags = @canned_food.tags
    @member = Member.find(current_member.id)
    
    @comment = Comment.new
    @comments = @review.comments.page(params[:page]).per(5)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    redirect_to request.referer
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :image)
  end
  
  def ensure_guest_member
    @member = Member.find(current_member.id)
    if @member.guest_member?
      redirect_to members_my_page_path, notice: "ゲスト会員はコメントの作成・削除はできません。"
    end
  end
end
