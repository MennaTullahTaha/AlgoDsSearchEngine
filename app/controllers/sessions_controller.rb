class SessionsController < ApplicationController
    def new 
        @user = User.new
    end 

    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            flash[:success] = "Successful login"
            session[:user_id] = user.id
            redirect_to user
        else
            flash.now[:alert] = "Wrong email or password"
            render 'new'
        end 

    end 
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "logged out successfully"
        redirect_to '/'
    end 
end