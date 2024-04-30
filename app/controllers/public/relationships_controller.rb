class Public::RelationshipsController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member

  def create
    @member = Member.find(params[:member_id])
    current_member.follow(@member)

    is_active_room
  end

  def destroy
    @member = Member.find(params[:member_id])
    current_member.unfollow(@member)

    is_active_room
  end

  def followings
    @member = Member.find(params[:member_id])
    @members = @member.followings
  end

  def followers
    @member = Member.find(params[:member_id])
    @members = @member.followers
  end


  private
    def ensure_guest_member
      @member = Member.find(current_member.id)
      if @member.guest_member?
        redirect_to members_my_page_path, notice: "ゲスト会員はフォローできません。"
      end
    end

    def is_active_room
      # roomが作成された時に現在ログインしている会員と、
      # メッセージ相手になる会員の両方をEntriseテーブルから取得する。
      @current_entry = Entry.where(member_id: current_member.id)
      @another_entry = Entry.where(member_id: @member.id)

      # 現在ログインしている会員ではない場合にメッセージを行う。
      unless @member.id == current_member.id
        # entryテーブル内に同じroom_idがある場合は、
        # 既にroomがあるため、@is_roomにtrueを設定する。
        @current_entry.each do |current|
          @another_entry.each do |another|
            if current.room_id == another.room_id
              @is_room = true
              @room_id = current.room_id
            end
          end
        end

        # @is_roomがtrueではない場合に、新規でroomを作成する。
        unless @is_room
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
end
