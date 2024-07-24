module Public::NotificationsHelper
   def notification_message(notification)
    case notification.notifiable_type
    when "GroupUser"
      "#{notification.notifiable.user.name}のグループ参加が承認されました"
    else
      "#{notification.notifiable.group.name}に#{notification.notifiable.user.name}さんから参加申請が届いています"
    end
   end
end
