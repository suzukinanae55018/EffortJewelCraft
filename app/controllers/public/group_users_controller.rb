class Public::GroupUsersController < ApplicationController
 before_action :authenticate_user!

  def create
    group_user = current_user.group_users.new(group_id: params[:group_id])

    if group_user.save
      flash[:notice] = "グループの入会に成功しました。"
      redirect_to request.referer
    else
      flash.now[:alert] = "グループの入会に失敗しました。"
      render :show
    end
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])

    if group_user.destroy
      flash[:notice] = "グループの退会に成功しました。"
      redirect_to groups_path
    else
      flash.now[:alert] = "グループの退会に失敗しました。"
      render :show
    end
  end
end
