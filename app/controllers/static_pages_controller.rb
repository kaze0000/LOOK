class StaticPagesController < ApplicationController
  skip_before_action :require_login
  after_action :reset

  def top
    if current_user
      @selected_bottoms = Clothe.joins(:user_clothes).where(category: 2, user_clothes: {selected: true})
      @selected_tops = Clothe.joins(:user_clothes).where(category: [0,1], user_clothes: {selected: true})
    end
  end

  def reset
    UserClothe.includes(:user, :clothe).where(selected: true).update(selected: false)
  end
end
