class Public::MembersController < ApplicationController
  def index
    @member = Member.find(current_member.id)
  end

  def edit
    @member = Member.find(current_member.id)
  end

  def update
    @member = Member.find(current_member.id)

    if @member.update(member_params)
      flash[:notice] = "更新が完了しました。"
      redirect_to members_my_page_path
    else
      render :edit
    end
  end

  def show
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private

  def member_params
    params.require(:member).permit(:nickname, :phone_number, :email, :password, :password_confirmation, :image)
  end
end
