module HocNotifications
  class HocNotificationAction
    def initialize(action:, title:, message:, sender:, recipients:, notifiable:, data: )

    end
    attr_accessor :action, :message, :title, :sender, :recipients, :notifiable, :data
  end
end
