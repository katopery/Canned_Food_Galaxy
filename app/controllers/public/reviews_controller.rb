class Public::ReviewsController < ApplicationController
  def index
  end

  def show
  end

  def create
    @review = current_member.reviews.new(review_params) 

    if @review.save!
      flash[:success] = 'レビューを投稿しました。'
      redirect_to review_comments_path(@review.id)
    else
      flash[:error] = 'レビューを投稿に失敗しました。'
      redirect_to canned_food_path(@review.canned_food_id)
    end
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to review_comments_path(review_id: @review.id)
    else
      redirect_to canned_food_path(@review.canned_food_id)
    end
  end
  
  def destroy
  end
  
  private
  
  def review_params
    params.require(:review).permit(:canned_food_id, :expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating) 
  end
end
