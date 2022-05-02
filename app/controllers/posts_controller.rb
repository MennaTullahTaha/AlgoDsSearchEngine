class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    def show
        
    end 

    def index
        @posts = Post.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            redirect_to @post
            flash[:notice] = "created successfully"
        else
            render 'new'
        end
    end
    
    def edit
    end

    def destroy
        @post.destroy
        flash[:notice] = "deleted successfully"
        redirect_to posts_path
    end

    def update
        if @post.update(params.require(:post).permit(:title, :body))
          flash[:notice] = "post was updated successfully."
          redirect_to @post
        else
          render 'edit'
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def require_same_user
        if current_user != @article.user
          flash[:alert] = "You can only edit or delete your own article"
          redirect_to @article
        end
      end
end 