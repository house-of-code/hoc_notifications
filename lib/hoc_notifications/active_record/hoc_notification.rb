module HocNotifications
  class HocNotification < ActiveRecord::Base
    belongs_to :recipient, polymorphic: true
    belongs_to :sender, polymorphic: true
    belongs_to :notifiable, polymorphic: true

    scope :unread, -> { where(seen_at: nil) }

    serialize :data, Hash

    after_create -> {
      return if recipient.nil?
      if recipient.class.method_defined? :handle_received_notification
        recipient.handle_received_notification(self)
      end
    }

    def self.create_notifications(sender:, recipients:, notifiable:, action:, title:, message:, **data)
      recipients.each do |recipient|
        create(sender: sender,
               recipient: recipient,
               notifiable: notifiable,
               action: action,
               data: data,
               seen_at: nil,
               title: title,
               message: message
             )
      end
    end

    def mark_as_seen
      update_attributes(seen_at: Time.current)
    end
  end
end
