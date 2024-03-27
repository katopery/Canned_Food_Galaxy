class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member
  
  def create
    member = Member.find(params[:member_id])
    current_member.follow(member)
    redirect_to request.referer
  end
  
  def destroy
    member = Member.find(params[:member_id])
    current_member.unfollow(member)
    redirect_to  request.referer
  end
  
  def followings
    member = Member.find(params[:member_id])
    @members = member.followings
  end
  
  def followers
    member = Member.find(params[:member_id])
    @members = member.followers
  end
  
  
  private
  def ensure_guest_member
    @member = Member.find(current_member.id)
    if @member.guest_member?
      redirect_to members_my_page_path, notice: "ゲスト会員はフォローできません。"
    end
  end
end
