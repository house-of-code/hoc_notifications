# HocNotifications

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hoc_notifications`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hoc_notifications'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hoc_notifications

## Usage

### Make application ready for hoc_notifications
Install by running:

    $ rails generate hoc_notifications:install


    $ rake db:migrate
This will create, models and migrations

### Extend models

#### Receiver
Add the `acts_as_hoc_notications_receiver` to models you want to be able to receive notifications and override `handle_received_notification(hoc_notification)` to get notified in the model when a notifications is received. This can be used to eg. send a push notification with acts_s_hoc_pushable

```ruby
#app/models/user.rb
class User < ApplicationRecord
  acts_as_hoc_notifications_receiver
  #acts_as_hoc_pushable

  def handle_received_notification(hoc_notification)
    # handle notification here. eg send push notification
    #send_push_notification(....)
  end
end
```
The model now has a has_many `received_notifications` relation.
The model also have a method called `mark_as_seen(id)` which can be used to mark a notification as seen.


#### Sender
Add the `acts_as_hoc_notications_sender` to models you want to be able to be used as sender for notifications
```ruby
#app/models/user.rb
class User < ApplicationRecord
  acts_as_hoc_notifications_receiver
  acts_as_hoc_notifications_sender
  #acts_as_hoc_pushable

  def handle_received_notification(hoc_notification)
    # handle notification here. eg send push notification
    #send_push_notification(....)
  end
end
```
As seen the receiver and sender can be the same model.
This extend the model with a has_many `sent_notifications` relation.

#### Notifiable
Add the `acts_as_hoc_notifications_notifiable` to models you want to be able to notify about.
```ruby
class Comment < ApplicationRecord
  acts_as_hoc_notifications_notifiable
  belongs_to :user
  belongs_to :post

  after_create :create_notification
  def create_notification
    Comment.create_notification(
      sender: user,
      recipients: (post.commented_users.to_a + [post.user] - [user]).uniq,
      notifiable: self,
      action: :create,
      title: "Created comment",
      message: "#{user.name} commented on #{post.title}",
      data: nil
    )
  end
end
class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :commented_users, through: :comments, source: :user

  acts_as_hoc_notifications_notifiable
end


```
This extend the model with a has_many `notifications` relation and the `create_notification` method
ActiveRecords callbacks, like `after_create` can be used to make a notification.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
