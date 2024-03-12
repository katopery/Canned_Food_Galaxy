class Admin::CannedFoodsController < ApplicationController
  def index
    @canned_foods = CannedFood.page(params[:page]).per(5)
  end

  def new
    @canned_food = CannedFood.new
  end

  def create
    @canned_food = CannedFood.new(canned_food_params)
  
    if @canned_food.save
      # 中間テーブル缶詰タグの保存
      canned_tags = @canned_food.canned_tags.build(tag_id: params[:canned_food][:tag_ids])
      canned_tags.save!
      # 保存成功した場合の処理
      redirect_to admin_canned_food_path(@canned_food.id),notice: "缶詰の登録が完了しました"
    else
      # 保存失敗した場合の処理
      render :new
    end
  end
  
  def show
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags
  end

  def edit
    @canned_food = CannedFood.find(params[:id])
    @tags = @canned_food.tags
  end

  def update
    @canned_food = CannedFood.find(params[:id])
    
    if @canned_food.update(canned_food_params)
      # 中間テーブル缶詰タグの更新
      @canned_food.tag_ids = params[:canned_food][:tag_ids]
      # 更新成功した場合の処理
      redirect_to admin_canned_food_path(@canned_food.id),notice: "缶詰情報が更新されました"
    else
      # 更新失敗した場合の処理
      render :edit
    end
  end
  
  def search
  end
  
  private

  def canned_food_params
    params.require(:canned_food).permit(:canned_name, :description, :image, :is_canned_status, tag_ids: [])
  end
end
