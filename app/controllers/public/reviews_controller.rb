class Public::ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @review = current_member.reviews.new(review_params) 
    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to review_comments_path(@review.review_id)
    end
  end

  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:member_id, :canned_food_id, :expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating) 
  end
end
