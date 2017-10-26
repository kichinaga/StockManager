class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  ### ログイン判定
  def is_user_logged
    if session[:user_id]
      unless User.exists?(id: session[:user_id])
        flash[:notice] = 'そのユーザーは存在しません'
        redirect_to login_url
      end
    else
      flash[:notice] = 'ログインしてください'
      redirect_to login_url
    end
  end
end
