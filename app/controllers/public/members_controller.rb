class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :ensure_guest_member, only: [:edit, :update, :unsubscribe, :withdraw]
  
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
      flash[:alert] = "更新が失敗しました。"
      render "edit"
    end
  end

  def show
    # 会員情報編集画面で更新失敗後にリロードした場合、マイページに遷移
    return redirect_to members_my_page_path if params[:id] == "information"
    
    @member = Member.find(params[:id])
    
    # 削除されたページ数を計算し、現在のページ番号が削除範囲を超えている場合は修正する
    deleted_page = (@member.reviews.count / 5.0).ceil
    if params[:page].to_i > deleted_page
      params[:page] = deleted_page.to_s
    end
    
    # 削除後にページネーションを更新
    @reviews = @member.reviews.page(params[:page]).per(5)
    
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
    
    # 会員ステータスがtrueではない場合、会員のレビュー一覧画面に遷移できないようにする
    if @member.is_member_status != true
      redirect_to members_my_page_path, alert: 'この会員は退会済みです。'
      return
    end
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
      redirect_to members_my_page_path, notice: "ゲスト会員は更新・退会できません。"
    end
  end 
end
