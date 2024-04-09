class Public::RoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    @room = Room.create
    @current_entry = @room.entries.create(member_id: current_member.id, room_id: @room.id)
    @another_entry = @room.entries.create(member_id: params[:entry][:member_id], room_id: @room.id)
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    if @room.entries.where(member_id: current_member.id).present?
      @messages = @room.messages.all
      @message = Message.new
      @entries = @room.entries
      @another_entry = @entries.where.not(member_id: current_member.id).first
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
