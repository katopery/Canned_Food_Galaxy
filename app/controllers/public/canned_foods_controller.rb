class Public::CannedFoodsController < ApplicationController
  before_action :authenticate_member!

  def index
    if params[:sort_created_at]
      # 新着/古い順表示の処理
      @canned_foods = CannedFood.where(is_canned_status: true).order(params[:sort_created_at]).page(params[:page]).per(10)
    elsif params[:sort_review]
      # 各評価項目ごとの降順表示の処理
      @canned_foods = CannedFood.where(is_canned_status: true)
                                .left_joins(:reviews)
                                .group(:id)
                                .order("avg(reviews.#{params[:sort_review]}) desc")
                                .page(params[:page])
                                .per(10)
    elsif params[:find_review]
      # 各評価項目ごとの絞り込み表示の処理
      
      # `CannedFood`モデルのデータに関連する`reviews`テーブルとの結合。
      # `group(:id)`により、`CannedFood`レコードを`id`でグループ化。
      # `avg(reviews.#{params[:find_review]})`を使って指定された評価項目の平均値を計算し、`canned_food_id`を`id`として選択。
      # 上記の内容から各`CannedFood`のIDと指定された評価項目の平均値が含まれた結果のセットが取得。
      canned_foods = CannedFood.left_joins(:reviews).group(:id).select("canned_food_id as id, avg(reviews.#{params[:find_review]}) as ave")
      # 指定された評価項目の平均値が指定された`params[:rate]`よりも高いものを選択。
      # 選択された結果の中から、`pluck(:id)`を使ってその`CannedFood`のIDのみを取得
      ave = canned_foods.select{ |c| (c.ave||0) >= params[:rate].to_f}.pluck(:id)
      @canned_foods = CannedFood.where(id: ave, is_canned_status: true).page(params[:page]).per(10)
    else
      # 通常の表示処理
      @canned_foods = CannedFood.all.where(is_canned_status: true).page(params[:page]).per(10)
    end

    # 各評価項目ごとの絞り込み表示で選択した値を表示するための処理
    if params[:find_review] == "expiry_date_rating"
      @expiry_date_rating = params[:rate] || 1
    elsif params[:find_review] == "taste_rating"
      @taste_rating = params[:rate] || 1
    elsif params[:find_review] == "snack_rating"
      @snack_rating = params[:rate] || 1
    elsif params[:find_review] == "outdoor_rating"
      @outdoor_rating = params[:rate] || 1
    else
      # 何もしない
    end
  end

  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags

    # 各レビューの平均値算出
    @expiry_date_avg = @canned_food.reviews.average(:expiry_date_rating) || 0
    @taste_avg = @canned_food.reviews.average(:taste_rating) || 0
    @snack_avg = @canned_food.reviews.average(:snack_rating) || 0
    @outdoor_avg = @canned_food.reviews.average(:outdoor_rating) || 0

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
      redirect_to canned_foods_path, alert: 'この缶詰は表示できません'
      return
    end
  end

  def search
    @word = params[:word]
    @search = params[:search]
    @range = params[:range]

    # 検索された缶詰に関連付けられたCannedFoodを取得
    if @range == "缶詰"
      @canned_foods = CannedFood.where(is_canned_status: true).looks(@search, @word).page(params[:page]).per(10)
    end
  end

  def search_tag
    # タグIDが存在しているかチェック
    if params[:tag_id].present?
      # 検索されたタグを受け取る
      @tag = Tag.find(params[:tag_id])
      # 検索されたタグに関連付けられたCannedTagを取得
      @canned_tags = @tag.canned_tags.joins(:canned_food).where("canned_foods.is_canned_status = ?", true).page(params[:page]).per(10)
      # 検索されたタグに関連付けられたCannedFoodを取得
      @canned_foods = @canned_tags.map(&:canned_food)
    else
      # タグIDが指定されていない場合、タグIDを0として処理をする
      @tag = nil
      @canned_tags = Kaminari.paginate_array([]).page(params[:page]).per(10)
      @canned_foods = []
    end
  end
end
