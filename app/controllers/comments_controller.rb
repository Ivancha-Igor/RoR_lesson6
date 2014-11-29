class CommentsController < ApplicationController
  before_action :authenticate, only: [:create, :update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post), notice: 'Ваш комментарий успешно сохранен'
    end
  end


  def update
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.user = current_user
    if @comment.user
      @comment.destroy
    end
    redirect_to post_path(@post)
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
