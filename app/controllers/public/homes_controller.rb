class Public::HomesController < ApplicationController
  def top
    @canned_foods = CannedFood.where(is_canned_status: true).order(created_at: :desc).limit(5)
  end
end
