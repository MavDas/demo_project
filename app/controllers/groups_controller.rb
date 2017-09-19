class GroupsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def new
    @users = User.all
    @memberships = @users.map{ |user| @group.memberships.build({user_id: user.id}) }
  end

  def create
    group = Group.new(group_params)
    respond_to do |format|
      group.created_by = current_user.name
      if group.save
        group.users << current_user
        format.html { redirect_to groups_path, notice: 'Group was successfully created.' }
        # format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        # format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @member = Membership.where(user_id: current_user.id)
    @groups = Group.all
  end

  def edit
    render :layout => false
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to groups_path, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.js{ }
    end
  end

  
  def show
    @members = Membership.all
    @users = User.all
    render :layout => false
  end


  private 
  def group_params
    params.require(:group).permit(:name, :description, :is_public,
                                  memberships_attributes: [:user_id,[]])
  end
end
