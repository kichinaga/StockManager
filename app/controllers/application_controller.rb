class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  ### ログイン判定
  def is_user_logged
   unless session[:user_id]
     flash[:notice] = "ログインしてください"
     redirect_to sessions_login_url
   end
  end
end
