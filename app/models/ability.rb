# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user && user&.admin?

    can :access, :rails_admin # 管理者画面のアクセス許可
    can :manage, :all # 管理権限許可
  end
end
