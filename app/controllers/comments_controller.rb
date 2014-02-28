class CommentsController < ApplicationController

  def create
  puts "COMMENT CREATE = #{params.inspect}"
  @comment = Comment.new(params[:comment].merge({ user: current_user } ))

  # @post = Post.find(params[:post_id])

  # @comment.post = @post
  # @comment.user = current_user

  # @topic = Topic.find(params[:topic_id])
  authorize! :create, @comment, message: " You need to be an member to do that."
  if @comment.save
    flash[:notice] = "Comment saved successfully"
  else
    flash[:error] = "Error saving comment. Please try again"    
  end
  redirect_to [@comment.post.topic, @comment.post]
 end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])
    
    @comment = @post.comments.find(params[:id])
    authorize! :destroy, @comment, message:  "You have to own the comment to delete it."

    if @comment.destroy
      flash[:notice] = "Comment was completely destroyed!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment has issues being destroyed. Please try again"
      redirect_to [@topic, @post]
    end 
  end
end