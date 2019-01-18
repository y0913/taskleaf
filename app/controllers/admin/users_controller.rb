class Admin::UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = user.find(params[:id])
  end

  def create
  	@user = Use.new(user_params)

  	if user.save
  		redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を登録しました"
  	else
  		render :new
  	end
  end

  def update
  	@user = user.find(params[:id])

  	if @user.update(user_params)
  		redirect_to admin_users_path(@user), notice: "ユーザー#{「@user.name」}を更新しました。"
  	else
  		render :new
  	end
  end

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to admin_users_url, notice: "ユーザー#{@user.name}を削除しました。"
  end

  private

  def user_params
  	params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
end