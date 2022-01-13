class Clothe < ApplicationRecord
  mount_uploader :image, ClotheImageUploader
  has_many :users, through: :user_clothes
  has_many :user_clothes, dependent: :destroy
  belongs_to :brand_name

  enum category: { tops: 0, outer: 1, bottoms: 2 }
  enum gender: { mens: 0, womens: 1 }

  validates :category, presence: true
  validates :gender, presence: true
  validates :image, presence: true
end
