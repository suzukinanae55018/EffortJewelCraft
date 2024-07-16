class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def show
    @user = User.find(params[:id])
    @diary_records = @user.diary_records.order(created_at: :desc).page(params[:page]).per(15)
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash[:notice] = "ユーザーを削除しました。"
      redirect_to admin_users_path
    else
      flash.now[:alert] = "ユーザーの削除に失敗しました。"
      render :show
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end
end
