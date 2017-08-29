class CommentsController < ApplicationController
	before_filter :authenticate_user!
	load_and_authorize_resource	

	def create
		@group = Group.find(params[:group_id])
		@post = @group.posts.find(params[:post_id])
		@comment = @post.comments.create(comment_params)

		redirect_to group_post_path(@group,@post)
	end

	def destroy
		@group = Group.find(params[:group_id])
		@post = @group.posts.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to group_post_path(@group,@post)
	end

	private
	def comment_params
		params.require(:comment).permit(:name, :body)
	end
end
