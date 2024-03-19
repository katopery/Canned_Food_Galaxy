# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :member_state, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    root_path
  end
  
  # ゲスト会員でログインするメソッド
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to members_my_page_path, notice: 'ゲスト会員としてログインしました。'
  end
  
  protected
  
   # 会員ステータスがアクティブであるかを判断するメソッド
  def member_state
    # 入力されたemailからアカウントを1件取得
    members = Member.find_by(email: params[:member][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if members.nil?
    # パスワードが正しくない場合、このメソッドを終了する
    return unless members.valid_password?(params[:member][:password])
    # アクティブな会員はcreateアクションを実行
    # 退会している会員はサインアップ画面に遷移する

    if members.is_member_status == false
      flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
      redirect_to new_member_registration_path
    end
  end

end
