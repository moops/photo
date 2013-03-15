class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user
    
    if user.role? :admin
      can :manage, :all
    else
      can :read, :all
      can :manage, User
      if user.role?(:photographer)
        can :manage, Gallery do |g|
          g.try(:user) == user or g.new_record?
        end
        can :manage, Photo do |p|
          p.gallery.try(:user) == user or p.new_record?
        end
        can :manage, Comment do |c|
          c.photo.gallery.try(:user) == user or c.new_record?
        end
      end
    end
  end
end