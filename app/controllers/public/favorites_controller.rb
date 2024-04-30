class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member

  def create
    @canned_food = CannedFood.find(params[:canned_food_id])
    current_member.favorite(@canned_food)
  end

  def index
    @favorites = current_member.favorites.includes(:canned_food, :member).order(created_at: :desc)
    @canned_foods = @favorites.map(&:canned_food)
  end

  def destroy
    @canned_food = current_member.favorites.find_by(id: params[:id])&.canned_food
    current_member.unfavorite(@canned_food)
  end

  private
    def ensure_guest_member
      @member = Member.find(current_member.id)
      if @member.guest_member?
        redirect_to members_my_page_path, notice: "ゲスト会員はお気に入り登録・削除できません。"
      end
    end
end
