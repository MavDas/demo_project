class GroupsController < ApplicationController
	before_filter :authenticate_user!
  load_and_authorize_resource

  def new
  	
  end

  def create
	  @group = Group.new(group_params)

	  respond_to do |format|
	    if @group.save
	    	@group.users << current_user
	      format.html { redirect_to add_members_group_path(@group), notice: 'Group was successfully created.' }
	      # format.json { render :show, status: :created, location: @group }
	    else
	      format.html { render :new }
	      # format.json { render json: @group.errors, status: :unprocessable_entity }
	    end
	  end
	end

	def add_members
		@users = User.all
	end

  def index
  end

  def update
  	respond_to do |format|
	  	@group = Group.find(params[:group_id])
	    @user = User.find(params[:user_id])
	    @group.users << @user unless @group.users.include? @user
	    format.html { redirect_to add_members_group_path(@group), notice: 'Member was successfully added'}
	  end
  end

  def remove_member
  	respond_to do |format|
	  	@group = Group.find(params[:group_id])
	    @user = User.find(params[:user_id])
	    member = Membership.where(user_id:@user.id,group_id:@group.id)
	    Membership.delete(member)
	    format.html { redirect_to add_members_group_path(@group), notice: 'Member was successfully removed.' }      
	  end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def edit
  	render :layout => false
  end
  
  def show
  	@members = Membership.all
  	@users = User.all
  	render :layout => false
  end


  private 
  def group_params
  	params.require(:group).permit(:name, :description, :created_by)
  end
end
