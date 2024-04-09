class Public::MessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    # フォームから送信されたメッセージを取得し、現在の会員に関連付けて保存
    @message = current_member.messages.new(message_params)
    
    if @message.save
      # メッセージの保存が成功した場合の処理
      flash[:notice] = "メッセージの送信に成功しました。"
    else
      # メッセージの保存が失敗した場合の処理
      flash[:alert] = "メッセージの送信に失敗しました。"
    end
    
    redirect_to room_path(@message.room_id)
  end

  def destroy
    # ログイン中の会員に関連するメッセージを削除
    @message = current_member.messages.find(params[:id])
    
    if @message.destroy
      # メッセージの削除が成功した場合の処理
      flash[:notice] = "メッセージの削除に成功しました。"
    else
      # メッセージの削除が失敗した場合の処理
      flash[:alert] = "メッセージの削除に失敗しました。"
    end
    
    redirect_to room_path(@message.room_id)
  end


  private

  def message_params
    params.require(:message).permit(:content, :room_id)
  end
end
