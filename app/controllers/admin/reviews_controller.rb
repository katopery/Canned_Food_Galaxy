class Admin::ReviewsController < ApplicationController
  def index
    @canned_food = CannedFood.find(params[:canned_food_id])
    @reviews = @canned_food.reviews.page(params[:page]).per(5)
    @tags = @canned_food.tags
  end

  def show
    @member = Member.find(params[:member_id])
    @reviews = @member.reviews.page(params[:page]).per(5)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    
    redirect_to request.referer
  end
end
