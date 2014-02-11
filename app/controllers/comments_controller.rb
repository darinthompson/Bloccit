class CommentsController < ApplicationController

 def create
  puts "COMMENT CREATE = #{params.inspect}"
  @comment = Comment.new(params[:comment].merge({ :user => current_user } ))

  # @post = Post.find(params[:post_id])

  # @comment.post = @post
  # @comment.user = current_user

  # @topic = Topic.find(params[:topic_id])
  authorize! :create, @comment, message: " You need to be an member to do that."
  if @comment.save
    r = "Comment was saved successfully."
  else
    puts "COMMENT CREATE FAILED: #{@comment.errors.inspect}"
    flash[:error] = "Error creating comment. Please try again."
    r = "Error saving comment. Please try again"    
  end
  redirect_to [@comment.post.topic, @comment.post], notice: r

 end
end