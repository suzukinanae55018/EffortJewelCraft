class Public::GroupUsersController < ApplicationController
 before_action :authenticate_user!

  def create
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @group_user = GroupUser.create(user_id: @permit.user_id, group_id: params[:group_id])
    @permit.destroy #参加希望者リストから削除
    redirect_to request.referer,notice: "グループ参加を承認しました。"
  end

  def decline
    @group = Group.find(params[:group_id])
    @permit = Permit.find(params[:permit_id])
    @permit.destroy #参加希望者リストから削除
    redirect_to request.referer, notice: "グループ参加を拒否しました。"
  end

  def destroy
    group_user = current_user.group_users.find_by(group_id: params[:group_id])
      group_user.destroy
      redirect_to request.referer, notice: "グループから退会をしました。"
  end
end
