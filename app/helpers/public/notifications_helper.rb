module Public::NotificationsHelper
   def notification_message(notification)
    case notification.notifiable_type
    when "GroupUser"
      "#{notification.notifiable.group.name}へのグループ参加が承認されました"
    else
      "#{notification.notifiable.group.name}に#{notification.notifiable.user.name}さんから加入申請が届いています"
    end
   end
end
