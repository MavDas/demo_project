class PostsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource  
  
  def index
     if check_access?
      @post= Post.where(group_id: @group.id)
    end
  end  

  def new    
    @group = Group.find(params[:group_id])
  end  

  def create
    if check_access?
      post = Post.new(post_params)
      post.user_id = current_user.id
      post.group_id = @group.id
      if post.save!
        flash[:success] = "Post created!"
        redirect_to group_posts_path
      else
        redirect_to root_url
      end
    end
  end

  def show
    if check_access?
      @post = Post.find(params[:id])
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to group_posts_url, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to group_posts_url, notice: 'Post was successfully destroyed.' }
      format.js {}
    end
  end

  private    
  def post_params      
    params.require(:post).permit(:title,:body, :group_id, :user_id)    
  end
  
end