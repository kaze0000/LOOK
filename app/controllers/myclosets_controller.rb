class MyclosetsController < ApplicationController
  before_action :require_login
  def index
    @my_clothes = current_user.clothes
  end
end
