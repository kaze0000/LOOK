class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :clothes, through: :user_clothes
  has_many :user_clothes, dependent: :destroy
  has_many :fittings, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  validates :name, presence: true, length: { maximum:255 }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password,confirmation: true,if:->{new_record? || changes[:crypted_password]}
  validates :password_confirmation,presence: true,if:->{new_record? || changes[:crypted_password]}

  def guest?
    self.name == 'ゲスト'
  end
end
