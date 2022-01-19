class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email],params[:password])
    if @user
      redirect_back_or_to myclosets_path
      flash[:alert] = 'ようこそ' + @user.name + 'さん'
    else
      flash.now[:alert] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  def guest_login
    @guest_user = User.create(
      name: 'ゲスト',
      email: SecureRandom.alphanumeric(10) + "@email.com",
      password: 'password',
      password_confirmation: 'password'
    )
    auto_login(@guest_user)
    redirect_to myclosets_path
    flash[:alert] = 'ようこそ' + @guest_user.name + 'さん'
  end
end
