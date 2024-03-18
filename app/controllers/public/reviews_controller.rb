class Public::ReviewsController < ApplicationController
  def index
    @canned_food = CannedFood.find(params[:canned_food_id])
    @reviews = @canned_food.reviews.page(params[:page]).per(5)
    @tags = @canned_food.tags
  end

  def create
    @review = current_member.reviews.new(review_params) 

    if @review.save
      flash[:success] = 'レビューを投稿しました。'
      redirect_to review_comments_path(@review.id)
    else
      flash[:error] = 'レビューを投稿に失敗しました。'
      
      # render用データ
      @canned_food = CannedFood.find(@review.canned_food_id)
      @tags = @canned_food.tags
      @member = Member.find(current_member.id)
      @expiry_date_avg = @canned_food.reviews.average(:expiry_date_rating) || 0
      @taste_avg = @canned_food.reviews.average(:taste_rating) || 0
      @snack_avg = @canned_food.reviews.average(:snack_rating) || 0
      @outdoor_avg = @canned_food.reviews.average(:outdoor_rating) || 0
      
      render 'public/canned_foods/show'
    end
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      flash[:notice] = "レビューの更新が完了しました。"
      redirect_to review_comments_path(review_id: @review.id)
    else
      flash[:error] = 'レビューの更新に失敗しました。'
      
      # render用データ
      @canned_food = CannedFood.find(@review.canned_food_id)
      @tags = @canned_food.tags
      @member = Member.find(current_member.id)
      @expiry_date_avg = @canned_food.reviews.average(:expiry_date_rating) || 0
      @taste_avg = @canned_food.reviews.average(:taste_rating) || 0
      @snack_avg = @canned_food.reviews.average(:snack_rating) || 0
      @outdoor_avg = @canned_food.reviews.average(:outdoor_rating) || 0
      
      render 'public/canned_foods/show'
    end
  end
  
  def destroy
    review = Review.find(params[:id])
    canned_food = CannedFood.find(review.canned_food_id)
    
    review.destroy
    redirect_to canned_food_path(canned_food)
  end
  
  private
  
  def review_params
    params.require(:review).permit(:canned_food_id, :expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating) 
  end
end
