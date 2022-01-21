class StaticPagesController < ApplicationController
  skip_before_action :require_login
  after_action :reset
  def top
    @selected_bottoms = Clothe.joins(:user_clothes).bottoms.merge(UserClothe.selected(current_user))
    @selected_tops = Clothe.joins(:user_clothes).tops.merge(UserClothe.selected(current_user))
  end

  def reset
    UserClothe.includes(:user, :clothe).selected(current_user).update(selected: false)
  end

  def serveice; end
end
