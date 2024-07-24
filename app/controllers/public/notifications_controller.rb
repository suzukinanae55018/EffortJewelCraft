class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)
    # 通知の種類によるリダイレクトパスの生成
    case notification.notifiable_type
    when "GroupUser"
      redirect_to group_path(notification.notifiable.group)
    else
      redirect_to permits_path(notification.notifiable.group.id)
    end
  end
end
