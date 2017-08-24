 class UsersController < ApplicationController
 # before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    if params[:approved] == "false"
      @users = User.where(approved: false)
    else
      @users = User.all
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @joined_on = @user.created_at.to_formatted_s(:short)
    if @user.current_sign_in_at
      @last_login = @user.current_sign_in_at.to_formatted_s(:short)
    else
      @last_login = "never"
    end
    render :layout => false
  end

  # GET /users/new
  def new
  #  @user = User.new
  end

  # GET /users/1/edit
  def edit
    authorize! :edit, @item
    render :layout => false
  end

  # POST /users
  # POST /users.json
  def create
    #@user = User.new(user_params)
    respond_to do |format|
      if @user.save
        User.invite!(:email => user.email, :name => user.name)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        @user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        redirect_to @user, notice: 'Your profile was successfully updated.'
      else
        @show_errors = true
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end
    if @user == current_user
      successfully_updated = @user.update(user_params_restricted)
    else
      successfully_updated =  if needs_password?(@user, user_params)
                                @user.update(user_params)
                              else
                                @user.update_without_password(user_params)
                              end
    end
    respond_to do |format|
      if successfully_updated
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    user = User.find(params[:id])
    user.update(approved: params[:approved])
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end
  protected
  def needs_password?(user, params)
    params[:password].present?
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation , :name, :role_id, :approved)
  end
  
  def user_params_restricted
    params.require(:user).permit(:name)
  end
end