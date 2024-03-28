class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
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
    
    if review.destroy
      flash[:notice] = "レビューを削除しました。"
      redirect_to request.referer
    else
      flash[:alert] = "レビューの削除が失敗しました。"
      render :show
    end
  end
end
