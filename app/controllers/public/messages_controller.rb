class Public::MessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    # フォームから送信されたメッセージを取得し、現在の会員に関連付けて保存
    @message = current_member.messages.new(message_params)
    if @message.save
      # 非同期化通信用、表示データ
      @room = @message.room
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
      @another_entry = @entries.where.not(member_id: current_member.id).first
    end
  end

  def destroy
    # ログイン中の会員に関連するメッセージを取得
    @message = current_member.messages.find(params[:id])
    # 非同期化通信用、表示データ
    @room = @message.room
    @messages = @room.messages.all
    @entries = @room.entries
    @another_entry = @entries.where.not(member_id: current_member.id).first
    # メッセージを削除
    @message.destroy
  end


  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
