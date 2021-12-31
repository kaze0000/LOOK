class StaticPagesController < ApplicationController
  def top
    @selected_bottoms = Clothe.where(selected: true, genre: 2)
    @selected_tops = Clothe.where(selected: true, genre: [0,1])
  end
end
