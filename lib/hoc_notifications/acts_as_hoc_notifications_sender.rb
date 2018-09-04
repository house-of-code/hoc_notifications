module HocNotifications
  module ActsAsHocNotificationsSender
    extend ActiveSupport::Concern

    included do
    end


    module ClassMethods
      def acts_as_hoc_notifications_sender(_options = {})
        has_many :sent_notifications,
                 as: :sender,
                 class_name: 'HocNotifications::HocNotification',
                 dependent: :destroy
      end
    end
  end
end
ActiveRecord::Base.send :include,
                        HocNotifications::ActsAsHocNotificationsSender
