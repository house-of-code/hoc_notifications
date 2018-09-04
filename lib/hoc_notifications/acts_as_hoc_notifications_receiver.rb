module HocNotifications
  module ActsAsHocNotificationsReceiver
    extend ActiveSupport::Concern

    included do
    end

    module ClassMethods
      def acts_as_hoc_notifications_receiver(_options = {})
        has_many :received_notifications,
                 as: :recipient,
                 class_name: 'HocNotifications::HocNotification',
                 dependent: :destroy
      end
    end

    def handle_received_notification(hoc_notification)
    end

    def mark_notification_as_read(id)
      received_notifications.find(id).mark_as_seen
    end

  end
end
ActiveRecord::Base.send :include,
                        HocNotifications::ActsAsHocNotificationsReceiver
