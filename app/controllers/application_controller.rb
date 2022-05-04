# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :logged_in?
  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:alert] = 'You must be logged in to perform that action'
      redirect_to login_path
    end
  end

  helper_method :is_post_favourite?
  def is_post_favourite?(id)
    current_user.saved_posts.find_by(id: id)
  end

  helper_method :is_algorithm_favourite?
  def is_algorithm_favourite?(id)
    current_user.saved_algorithms.find_by(id: id)
  end

  helper_method :is_datastructure_favourite?
  def is_datastructure_favourite?(id)
    current_user.saved_datastructures.find_by(id: id)
  end
end
