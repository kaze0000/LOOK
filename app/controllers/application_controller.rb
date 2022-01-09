class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:alert] = 'ログインが必要です。'
    redirect_to main_app.login_path
  end
end
