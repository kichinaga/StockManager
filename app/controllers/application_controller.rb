class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  ### ログイン判定
  def is_user_logged
   unless session[:user_id]
     flash[:notice] = 'ログインしてください'
     redirect_to login_url
   end
  end
end
