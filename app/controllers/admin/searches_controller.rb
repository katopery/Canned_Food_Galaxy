class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  
  def search
    @word = params[:word]
    @range = params[:range]

    if @range == "缶詰"
      # 検索された缶詰に関連付けられたCannedFoodを取得
      @canned_foods = CannedFood.looks(@word).page(params[:page]).per(10)
      @paginate = @canned_foods
    elsif @range == "会員"
      # 検索された缶詰に関連付けられたMemberを取得
      @members = Member.looks(@word).page(params[:page]).per(10)
      @paginate = @members
    end
  end
end
