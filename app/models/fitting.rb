class Fitting < ApplicationRecord
  belongs_to :user
  validates :image, presence: true
end
