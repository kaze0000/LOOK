class StaticPagesController < ApplicationController
  skip_before_action :require_login
  after_action :reset
  def top
    @selected_bottoms = Clothe.joins(:user_clothes).where(category: 2, user_clothes: { selected: true, user_id: current_user })
    @selected_tops = Clothe.joins(:user_clothes).where(category: [0,1], user_clothes: { selected: true, user_id: current_user })
  end

  def reset
    UserClothe.includes(:user, :clothe).selected(current_user).update(selected: false)
  end
end
