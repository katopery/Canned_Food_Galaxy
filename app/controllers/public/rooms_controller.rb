class Public::RoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    @room = Room.create
    # ログイン中の会員IDとルームのIDを使用してエントリーを作成
    @current_entry = @room.entries.create(member_id: current_member.id, room_id: @room.id)
    # パラメーターから受け取った会員IDとルームのIDを使用してエントリーを作成
    @another_entry = @room.entries.create(member_id: params[:entry][:member_id], room_id: @room.id)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    # ログイン中の会員IDでエントリーが存在する場合
    if @room.entries.where(member_id: current_member.id).present?
      # ルームのすべてのメッセージを取得
      @messages = @room.messages.all
      # 新しいメッセージのインスタンスを作成
      @message = Message.new
      # ルームのエントリー全体を取得
      @entries = @room.entries
      # ログイン中の会員以外のメンバーのエントリーを取得し、最初のエントリーを@another_entryに代入
      @another_entry = @entries.where.not(member_id: current_member.id).first
    else
      # エントリーが存在しない場合、ルートパスにリダイレクト
      redirect_back(fallback_location: root_path)
    end
  end
end
