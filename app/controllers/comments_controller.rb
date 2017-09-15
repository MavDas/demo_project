class CommentsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource  
  before_action :find_commentable

  def new
    @comment = Comment.new
  end

  def create
    if check_access?
      @post = @group.posts.find(params[:post_id])
      if @commentable
        @comment = @commentable.comments.new comment_params
      else
        @comment = @post.comments.new comment_params
      end
      @comment.name = current_user.name
      if @comment.save!
        redirect_to group_post_path(@group,@post), notice: 'Your Comment has been successfully posted!'
      else
        redirect_to group_post_path(@group,@post), notice: 'Your Comment could not be posted!'
      end
    end
  end

  def destroy
    respond_to do |format|
      if check_access?
        @post = @group.posts.find(params[:post_id])
        @comment = Comment.find(params[:id])
        @comment.destroy
        format.html {redirect_to group_post_path(@group,@post), notice: "Comment was removed."}
        format.js { }
      end
    end
  end

  def edit    
    if check_access?
      @post = @group.posts.find(params[:post_id])    
      # @comment = @post.comments.find(params[:id])  
      if @commentable
        @comment = @commentable.comments.find(params[:id])
      else
        @comment = @post.comments.find(params[:id])
      end
    end
    render layout: false
  end    

  def update    
    respond_to do |format|
      if check_access?
        @post = Post.find(params[:post_id])      
        # @post = @group.posts.find(params[:post_id])    
        # @comment = @post.comments.find(params[:id])  
        if @commentable
          @comment = @commentable.comments.find(params[:id])
        else
          @comment = @post.comments.find(params[:id])
        end      
        if @comment.update(comment_params)          
          format.html{redirect_to group_post_path(@group,@post), notice: 'Comment has been editted.' }      
        else          
          render 'edit'      
        end  
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:name, :body,:post_id,:group_id,:id)
  end

  def find_commentable
    @commentable = Comment.find(params[:comment_id]) if params[:comment_id]
  end
end
