class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  ### ログイン判定
  # def is_logined
  #  unless session[:user_id]
  #    flash[:notice] = "ログインしてください"
  #    redirect_to login_path
  #  end
  # end
end
