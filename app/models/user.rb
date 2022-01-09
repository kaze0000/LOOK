class User < ApplicationRecord
  authenticates_with_sorcery!
  has_many :clothes, dependent: :destroy

  enum role: { general: 0, admin: 1 }

  validates :name, presence: true, length: { maximum:255 }
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }

  def guest?
    self.name == 'ゲスト'
  end
end
