class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create guest_login]

  def new; end

  def create
    @user = login(params[:email],params[:password])
    if @user
      redirect_back_or_to myclosets_path
    else
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
      password: 'password'
    )
    auto_login(@guest_user)
    redirect_to request.referer 
  end
end
