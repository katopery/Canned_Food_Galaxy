class Public::ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @review = current_member.reviews.new(review_params) 

    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to review_comments_path(@review.id)
    end
  end

  def update
    
  end
  
  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:canned_food_id, :expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating) 
  end
end
