class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @comments = @post.comments.paginate(page: params[:page], per_page: 5)
    end 

    def index
        @posts = Post.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @post = Post.new
    end
    
    def create
        @post = Post.new(post_params)
        if params[:algorithm_result_id] 
            @post.algorithm = Algorithm.find_by(id: params[:algorithm_result_id])
        elsif params[:datastructure_result_id]
            @post.datastructure = Datastructure.find_by(id: params[:datastructure_result_id])
        end 
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
        if @post.update(post_params)
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
        if current_user != @post.user
          flash[:alert] = "You can only edit or delete your own post"
          redirect_to @post
        end
    end
end 