class Admin::MembersController < ApplicationController
  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
  end

  def edit
  end

  def update
  end
end
