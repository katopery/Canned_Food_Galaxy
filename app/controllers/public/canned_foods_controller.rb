class Public::CannedFoodsController < ApplicationController
  before_action :authenticate_member!

  def index
    # 有効な缶詰を取得
    @canned_foods = CannedFood.where(is_canned_status: true)

    if params[:sort_created_at]
      # 新着/古い順表示の処理
      @canned_foods = @canned_foods.order(params[:sort_created_at])
    elsif params[:sort_review]
      # 各評価項目ごとの降順表示の処理
      @canned_foods = @canned_foods.left_joins(:reviews)
                                    .group(:id)
                                    .order("avg(reviews.#{params[:sort_review]}) desc")
    end

    # 評価項目ごとに絞り込みを行う
    rating_params = [:expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating]
    rating_params.each do |param|
      # 評価項目のパラメータが指定されているか確認
      next unless params[param]
      avg_column = "avg(reviews.#{param})"
      # 平均値が指定された評価値以上のものを選択する
      ids = @canned_foods.left_joins(:reviews)
                          .group(:id)
                          .having("#{avg_column} >= ?", params[param].to_f)
                          .pluck(:id)
      @canned_foods = @canned_foods.where(id: ids)
    end

    # デフォルトは10件ずつ表示し、ページネーションを適用
    @canned_foods = @canned_foods.page(params[:page]).per(10)

    # ビュー側で表示するための評価項目ごとの値を保持
    set_rating_params

    @path_for_sorted_ratings = canned_foods_path
  end

  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags

    if current_member
      # 会員がログインしている場合
      @member = Member.find(current_member.id)
      @review = Review.find_by(member_id: current_member.id, canned_food_id: params[:id])
    else
      # 会員がログインしていない場合
      @member = nil
    end

    # 新規レビュー作成用
    if @review == nil
      @review = @canned_food.reviews.build
    end

    # 缶詰の表示ステータスがtrueではない場合、詳細画面に遷移できないようにする
    if @canned_food.is_canned_status != true
      redirect_to canned_foods_path, alert: "この缶詰は表示できません"
      nil
    end
  end

  def search
    # 検索ワードを取得し、缶詰表示ステータスが有効な缶詰を取得
    @word = params[:word]
    @canned_foods = CannedFood.where(is_canned_status: true).looks(@word)

    if params[:sort_review]
      # 各評価項目ごとの降順表示の処理
      @canned_foods = @canned_foods.left_joins(:reviews)
                                    .group(:id)
                                    .order("avg(reviews.#{params[:sort_review]}) desc")
    end

    # 各評価項目ごとに絞り込みを行う
    rating_params = [:expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating]
    rating_params.each do |param|
      # 評価項目のパラメータが指定されているか確認
      next unless params[param]
      avg_column = "avg(reviews.#{param})"
      # 平均値が指定された評価値以上のものを選択する
      ids = @canned_foods.left_joins(:reviews)
                          .group(:id)
                          .having("#{avg_column} >= ?", params[param].to_f)
                          .pluck(:id)
      @canned_foods = @canned_foods.where(id: ids)
    end

    # デフォルトは10件ずつ表示し、ページネーションを適用
    @canned_foods = @canned_foods.page(params[:page]).per(10)

    # ビュー側で表示するための評価項目ごとの値を保持
    set_rating_params
  end

  def search_tag
    # タグIDを取得
    @tag_id = params[:tag_id]

    # タグIDの存在をチェック
    if @tag_id.present?
      # タグを取得
      @tag = Tag.find(@tag_id)

      # タグに関連付けられたCannedFoodを取得
      @canned_foods = @tag.canned_foods.where("canned_foods.is_canned_status = ?", true)

      # 評価項目ごとの降順表示の処理
      if params[:sort_review]
        @canned_foods = @canned_foods.left_joins(:reviews)
                                      .group(:id)
                                      .order("avg(reviews.#{params[:sort_review]}) desc")
      end

      # 各評価項目ごとに絞り込みを行う
      rating_params = [:expiry_date_rating, :taste_rating, :snack_rating, :outdoor_rating]
      rating_params.each do |param|
        # 評価項目のパラメータが指定されているか確認
        next unless params[param]
        avg_column = "avg(reviews.#{param})"
        # 平均値が指定された評価値以上のものを選択する
        ids = @canned_foods.left_joins(:reviews)
                            .group(:id)
                            .having("#{avg_column} >= ?", params[param].to_f)
                            .where(id: @canned_foods.ids)
                            .pluck(:id)
        @canned_foods = @canned_foods.where(id: ids)
      end
    else
      # タグIDが指定されていない場合
      @tag = nil
      @canned_foods = CannedFood.none
    end

    # ページネーションを適用
    @canned_foods = @canned_foods.page(params[:page]).per(10)

    # 表示する評価項目ごとの値を保持
    set_rating_params
  end

  private
    # ビュー側で表示するための評価項目ごとの値を保持
    def set_rating_params
      @expiry_date_rating = params[:expiry_date_rating]
      @taste_rating = params[:taste_rating]
      @snack_rating = params[:snack_rating]
      @outdoor_rating = params[:outdoor_rating]
    end
end
