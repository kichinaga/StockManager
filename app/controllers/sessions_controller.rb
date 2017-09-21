class SessionsController < ApplicationController
  def login_form
  end

  def login
    @user = User.find_by(email: params[:session][:email])

    if @user && @user.authenticate(params[:session][:password])
      flash[:notice] = 'ログインしました'
      session[:user_id] = @user.id
      redirect_to users_url
    else
      @error_message = 'メールアドレスまたはパスワードが間違っています'
      @email = params[:email]
      render action: :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to sessions_login_url
  end
end
