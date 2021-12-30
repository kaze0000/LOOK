class StaticPagesController < ApplicationController
  def top
    @selected_clothes = Clothe.find_by(selected: true)

  end
end
