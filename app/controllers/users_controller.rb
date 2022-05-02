class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:edit, :update, :favourite_post]
  before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def show
      @posts = @user.posts.paginate(page: params[:page], per_page: 5)
    end

    def index
      @users = User.paginate(page: params[:page], per_page: 5)
    end

    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] = "Welcome #{@user.username}, you have successfully signed up"
        redirect_to @user
      else
        render 'new'
        end
    end

    def edit
    end
    
    def update
      if @user.update(user_params)
        flash[:notice] = "Your account information was successfully updated"
        redirect_to posts_path
      else
        render 'edit'
        end
    end

    def favourite_post
      post = is_post_favourite?(params[:post_id])
      if !post
        current_user.saved_posts << Post.find_by(id: params[:post_id])
        flash[:notice] = "Added to favourites!"
        redirect_to display_favourite_posts_path
      else
        flash[:alert] = "Already Added!"
        redirect_to posts_path
      end
    end

    def display_favourite_posts
      @posts = current_user.saved_posts.paginate(page: params[:page], per_page: 5)
    end

    def remove_post_from_favourites
      post = Post.find_by(id: params[:post_id])
      if post.favourites.find_by(id: current_user.id)
        post.favourites.delete(current_user)
        flash[:alert] = "post removed from favourites"
        redirect_to display_favourite_posts_path
      else 
        flash[:danger] = "you can't unfavourite this post"
        redirect_to posts_path
      end
    end 

    def destroy
      @user.destroy
      session[:user_id] = nil
      flash[:notice] = "Account and all associated posts successfully deleted"
      redirect_to articles_path
    end

    
      private
      def user_params
        params.require(:user).permit(:username, :email, :password)
      end 

      def set_user
        @user = User.find(params[:id])
      end

      def require_same_user
        if current_user != @user
          flash[:alert] = "You can only edit or delete your own account"
          redirect_to @user
        end
      end
  
  end 