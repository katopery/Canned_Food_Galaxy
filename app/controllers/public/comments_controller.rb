class Public::CommentsController < ApplicationController
  def create
    review = Review.find(params[:review_id])
    comment = current_member.comments.new(comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to review_comments_path(review)
  end

  def index
    @review = Review.find(params[:review_id])
    @canned_food = @review.canned_food
    @reviewer = @review.member
    
    @comment = Comment.new
    @commenter = Member.new
  end

  def destroy
  end
  
  private

  def comment_params
     params.require(:comment).permit(:comment)
  end
end
