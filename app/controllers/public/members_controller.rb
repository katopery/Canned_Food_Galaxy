class Public::MembersController < ApplicationController
  before_action :ensure_guest_member, only: %i[update unsubscribe]
  
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
    @member = Member.find(params[:member_id])
    @reviews = @member.reviews.page(params[:page]).per(5)
  end

  def unsubscribe
  end

  def withdraw
    @member = current_member
    # is_member_statusカラムをfalseに変更することにより退会フラグを立てる
    @member.update(is_member_status: false)
    reset_session
    flash[:notice] = "退会が完了しました。またのご利用お待ちしております。"
    redirect_to root_path
  end
  
  private

  def member_params
    params.require(:member).permit(:nickname, :phone_number, :email, :password, :password_confirmation, :image)
  end
  
  def ensure_guest_member
    @member = Member.find(current_member.id)
    if @member.guest_member?
      redirect_to members_my_page_path , notice: "ゲスト会員の更新・削除はできません。"
    end
  end 
end
