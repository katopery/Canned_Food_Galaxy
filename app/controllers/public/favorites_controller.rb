class Public::FavoritesController < ApplicationController
  def create
    canned_food = CannedFood.find(params[:canned_food_id])
    current_member.favorite(canned_food)
    redirect_to request.referer
  end

  def index
    @favorite_canned_food = current_member.favorite_canned_foods.includes(:member).order(created_at: :desc)
  end

  def destroy
    canned_food = current_member.favorites.find_by(id: params[:id])&.canned_food
    current_member.unfavorite(canned_food)
    redirect_to request.referer
  end
end
