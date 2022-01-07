class StaticPagesController < ApplicationController
  after_action :reset

  def top
    if current_user
    @selected_bottoms = current_user.clothes.where(selected: true, genre: 2)
    # @selected_bottoms = Clothe.where(selected: true, genre: 2)
    @selected_tops = current_user.clothes.where(selected: true, genre: [0,1])
    else
      @selected_bottoms = Clothe.where(admin_clothe: true,selected: true, genre: 2)
      @selected_tops = Clothe.where(admin_clothe: true,selected: true, genre: [0,1])

    end
  end

  def reset
    Clothe.where(selected: true).update(selected: false)
  end
end
