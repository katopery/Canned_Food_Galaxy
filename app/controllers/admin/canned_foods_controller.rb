class Admin::CannedFoodsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @canned_foods = CannedFood.page(params[:page]).per(10)
  end

  def new
    @canned_food = CannedFood.new
  end

  def create
    @canned_food = CannedFood.new(canned_food_params)
  
    if params[:canned_food][:tag_ids] != "" && @canned_food.save
      # 中間テーブル缶詰タグの保存
      canned_tags = @canned_food.canned_tags.build(tag_id: params[:canned_food][:tag_ids])
      canned_tags.save!
      # 保存成功した場合の処理
      flash[:notice] = "缶詰の登録が完了しました。"
      redirect_to admin_canned_food_path(@canned_food.id)
    else
      # 保存失敗した場合の処理
      if params[:canned_food][:tag_ids] == ""
        flash[:alert] = "缶詰の登録が失敗しました。タグの選択を行って下さい。"
      else
        flash[:alert] = "缶詰の登録が失敗しました。"
      end
    
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
    
    if params[:canned_food][:tag_ids] != "" && @canned_food.update(canned_food_params)
      # 中間テーブル缶詰タグの更新
      @canned_food.tag_ids = params[:canned_food][:tag_ids]
      # 更新成功した場合の処理
      flash[:notice] = "缶詰の更新が完了しました。"
      redirect_to admin_canned_food_path(@canned_food.id)
    else
      # 更新失敗した場合の処理
      if params[:canned_food][:tag_ids] == ""
        flash[:alert] = "缶詰の更新が失敗しました。タグの選択を行って下さい。"
      else
        flash[:alert] = "缶詰の更新が失敗しました。"
      end
      
      render :edit
    end
  end
  
  private
  def canned_food_params
    params.require(:canned_food).permit(:canned_name, :description, :image, :is_canned_status, tag_ids: [])
  end
end
