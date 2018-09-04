module HocNotifications
  module ActsAsHocNotificationsNotifiable
    extend ActiveSupport::Concern
    included do
    end


    module ClassMethods
      def acts_as_hoc_notifications_notifiable(**options)
        has_many :notifications,
        as: :notifiable,
        class_name: 'HocNotifications::HocNotification',
        dependent: :nullify

      end

      def create_notification(sender:, recipients:, notifiable:, action:, title:, message:, **data)
        HocNotifications::HocNotification.create_notifications(
          sender: sender,
          recipients: recipients,
          notifiable: notifiable,
          action: action,
          title: title,
          message: message,
          **data
        )
      end

    end
  end
end
ActiveRecord::Base.send :include, HocNotifications::ActsAsHocNotificationsNotifiable
