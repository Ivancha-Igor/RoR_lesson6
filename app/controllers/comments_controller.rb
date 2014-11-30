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
    if @comment.user != current_user
      redirect_to post_path(@post), notice: 'Вы не можете удалять чужие комментарии!'
    else
      @comment.destroy
      redirect_to post_path(@post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
  def comment_user
    redirect_to :back unless @comment.user == current_user
  end

end
