class Fitting < ApplicationRecord
  mount_base64_uploader :image, FittingImageUploader
  belongs_to :user
  validates :image, presence: true
end
