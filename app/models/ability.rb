class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    user ||= User.new # guest user (not logged in)
    if user.Superadmin?   # Super Admin can access all
      can :manage, :all    
    end    
    if user.Admin?     # Admin have limited access.It can read read and create user but deleting power is only to super admin       
      can :read, User 
      can :new, Group 
      can :create, Group
      can :read, Group

      can :update, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)  
      end
      
      can :destroy, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)   
      end 

      can :edit, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)  
      end  

      can :add_members, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)   
      end

      can :add_member, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)   
      end

      can :remove_member, Group do |group|         
        group.try(:user) == user || group.created_by == (user.name)   
      end 

      can :edit, Post do |post|         
        post.try(:user) == user || post.user_id == user.id       
      end

      can :update, Post do |post|         
        post.try(:user) == user || post.user_id == user.id       
      end

      can :destroy, Post do |post|         
        post.try(:user) == user || post.user_id == user.id       
      end

      can :create, Post do |post|
        post.try(:user) == user
      end
      can :read, Post
      can :new, Post do |post|
        post.try(:user) == user
      end

      can :update, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name) 
      end   

      can :create, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)  
      end  

      can :destroy, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)  
      end   

      can :read, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)  
      end  

      can :edit, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)  
      end  

    end    
    if user.Regular?  # Regular user can only view Groups.It cant even access admin panel      
      can :read, Event 
      can :read, Group         
      can :read, Post  

      can :update, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)
      end

      can :create, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)
      end

      can :destroy, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)
      end

      can :read, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)
      end

      can :edit, Comment do |comment|         
        comment.try(:user) == user || comment.name == (user.name)
      end

    end        
  end
end
