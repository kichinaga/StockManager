class UsersController < ApplicationController
  ###TODO ログインしているか、確認する処理を各関数の前で実行する
  before_action :is_user_logged, only: [:show, :edit, :update, :destroy]


  def show
    ## ユーザーの詳細情報を表示、editやdestroyへ飛ばすボタンを作る
    @user = current_user
    @stocks = current_user.stocks.page(params[:page])
  end

  def new
    ## ユーザー新規作成機能
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      ## 成功した時
      flash[:notice] = '登録が完了しました'
      ## ログインも同時に行う
      log_in @user
      redirect_to root_url
    else
      ## 失敗した時
      render action: :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update(user_params)
      flash[:notice] = '更新しました。'
      redirect_to action: :show
    else
      render action: :edit
    end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
