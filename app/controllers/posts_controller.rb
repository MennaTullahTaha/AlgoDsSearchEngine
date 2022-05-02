class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    def show
        
    end 

    def index
        @posts = Post.all
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to @post
            flash[:notice] = "created successfully"
        else
            render 'new'
        end
    end
    
    def edit
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
end 