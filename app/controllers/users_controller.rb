class UsersController < ApplicationController
  ###TODO ログインしているか、確認する処理を各関数の前で実行する
  before_action :is_user_logged, only: [:index, :show, :edit, :update, :destroy]

  def index
    ## ログインしているIDから現在保持している株一覧を取得
    @user = current_user
  end

  def show
    ## ユーザーの詳細情報を表示、editやdestroyへ飛ばすボタンを作る
    @user = User.find_by(id: session[:user_id])
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
      redirect_to action: :index
    else
      ## 失敗した時
      render action: :new
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @user = User.find_by(id: session[:user_id])

    if @user.update(user_params)
      flash[:notice] = '更新しました。'
      redirect_to action: :show, id: @user.id
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
