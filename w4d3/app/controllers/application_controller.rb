class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def login user
    session[:session_token] = user.reset_session_token!
  end

  def redirect_to_index
    redirect_to cats_url if current_user
  end

  def right_owner
    cat = Cat.find(params[:id])
    unless current_user == cat.owner
      redirect_to cats_url
      flash[:errors] ||= []
      flash[:errors] << 'no.'
    end
  end
end
