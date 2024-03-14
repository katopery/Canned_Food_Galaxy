class Public::HomesController < ApplicationController
  def top
    @canned_foods = CannedFood.order(created_at: :desc).limit(5)
  end
end
