class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  before_action :ensure_guest_user, only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @diary_records = @user.diary_records.order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "ユーザー情報の更新に成功しました"
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "ユーザー情報の更新に失敗しました"
      render :edit
    end
  end

  def destroy
      user = User.find(params[:id])
      if user.destroy
        flash[:notice] = "ユーザーを削除しました。"
        redirect_to root_path
      else
        flash.now[:alert] = "ユーザーの削除に失敗しました。"
        render :edit
      end
  end

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(15)
    # if params[:name].present?
    #   @users = @users.where(name: params[:name])
    # end

    # if params[:category_id].present?

    # end
  end

  private
    def user_params
      params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user), notice: "他のユーザーのプロフィール編集はできません。"
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])

      if @user.email == "guest@example.com"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      end
    end
end
