class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])

    if @member.update(member_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to admin_member_path(@member.id)
    else
      flash[:alert] = "更新が失敗しました。"
      render :edit
    end
  end
  
  private
  def member_params
    params.require(:member).permit(:nickname, :phone_number, :email, :is_member_status, :image)
  end
end
