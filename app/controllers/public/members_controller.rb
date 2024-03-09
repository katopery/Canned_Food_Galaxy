class Public::MembersController < ApplicationController
  def index
    @member = Member.find(current_member.id)
  end

  def edit
  end

  def update
  end

  def show
  end

  def unsubscribe
  end

  def withdraw
  end
  
  private

  def member_params
    params.require(:member).permit(:nickname, :phone_number, :email, :password, :password_confirmation)
  end
end
