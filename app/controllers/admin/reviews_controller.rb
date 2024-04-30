class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @canned_food = CannedFood.find(params[:canned_food_id])
    @tags = @canned_food.tags

    # 削除されたページ数を計算し、現在のページ番号が削除範囲を超えている場合は修正する
    deleted_page = (@canned_food.reviews.count / 5.0).ceil
    if params[:page].to_i > deleted_page
      params[:page] = deleted_page.to_s
    end

    # 削除後にページネーションを更新
    @reviews = @canned_food.reviews.page(params[:page]).per(5)
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
