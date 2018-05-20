class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Request, Comment]
    can :comment, [Request]

    alias_action :update, :destroy, to: :subject_pull
    can :subject_pull, [Request, Comment] do |type|
      user.owner_of?(type)
    end
  end
end