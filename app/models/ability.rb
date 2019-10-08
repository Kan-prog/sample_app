class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    user ||= User.new
    # user = current_user
    if user.admin?
      can :manage, :all
    else
      can :read, :all
      cannot :manage, ActiveAdmin::Page # roleがadmin以外であればactiveadminの各種ページにアクセス出来ないようにした
    end
  end
  
end

# class Ability
#   include CanCan::Ability
#   def initialize(user)
#     cannot :manage, all
#   end

#   def a
#     can :manage, all
#   end
# end