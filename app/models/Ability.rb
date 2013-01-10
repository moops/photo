class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can :manage, User
      if user.role?(:contributor)
        can :manage, Event do |p|
          p.try(:user) == user
        end
      end
    end
  end
end