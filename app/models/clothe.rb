class Clothe < ApplicationRecord
  mount_uploader :image, ClotheImageUploader
  belongs_to :user
  belongs_to :brandname

  enum type: { tops: 0, outer: 1, bottoms: 2 }
  enum gender: { mens: 0, womens: 1 }
end
