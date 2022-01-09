class StaticPagesController < ApplicationController
  skip_before_action :require_login
  after_action :reset

  def top
    if current_user
      @selected_bottoms = current_user.clothes.where(selected: true, genre: 2)
      @selected_tops = current_user.clothes.where(selected: true, genre: [0,1])
    end
  end

  def reset
    Clothe.includes(:user,:brand_name).where(selected: true).update(selected: false)
  end
end
