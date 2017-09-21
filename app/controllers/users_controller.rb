class UsersController < ApplicationController
  ###TODO ログインしているか、確認する処理を各関数の前で実行する
  # before_action :is_logined, only: [:index, :show, :edit, :update, :destroy]

  def index
    ## ログインしているIDから現在保持している株一覧を取得
    # @stocks = User.find_by(id: session[:user_id]).stocks
  end

  def show
    ## ユーザーの詳細情報を表示、editやdestroyへ飛ばすボタンを作る
  end

  def new
    ## ユーザー新規作成機能
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if user.save
      ## 成功した時

      ## ログインも同時に行う
      # session[:user_id] = user.id
      redirect_to action: :index
    else
      ## 失敗した時
      render action: :new
    end
  end

  def edit

  end

  def update
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
