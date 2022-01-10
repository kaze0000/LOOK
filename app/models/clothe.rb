class Clothe < ApplicationRecord
  mount_uploader :image, ClotheImageUploader
  belongs_to :user
  belongs_to :brand_name

  enum genre: { tops: 0, outer: 1, bottoms: 2 }
  enum gender: { mens: 0, womens: 1 }

  validates :genre, presence: true
  validates :gender, presence: true
  validates :image, presence: true
end
