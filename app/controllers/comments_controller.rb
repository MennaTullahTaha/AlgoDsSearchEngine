# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_comment, except: %i[new create]
  before_action :require_same_user, except: %i[create new]

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:comment][:post_id])
    @comment = Comment.new(param_permit)
    @comment.user = current_user
    @comment.post = post
    if @comment.save
      redirect_to post_path(post)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @comment.update(param_permit)
      flash[:notice] = 'comment was updated successfully.'
      redirect_to @comment.post
    else
      render 'edit'
    end
  end

  def destroy
    post = @comment.post
    @comment.destroy
    redirect_to post
  end

  private

  def param_permit
    params.require(:comment).permit(:body)
  end

  def require_same_user
    if current_user != @comment.user
      flash[:alert] = 'You can only edit or delete your own post'
      redirect_to @post
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
