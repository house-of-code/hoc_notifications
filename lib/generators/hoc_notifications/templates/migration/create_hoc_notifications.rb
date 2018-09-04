class CreateHocNotifications < ActiveRecord::Migration
  def change
    create_table :hoc_notifications do |t|
      t.integer :recipient_id
      t.string :recipient_type

      t.integer :sender_id
      t.string :sender_type

      t.integer :notifiable_id
      t.string :notifiable_type

      t.string :title, null: false, default: ""
      t.string :message, null: false, default: ""

      t.string :action, null: false, default: ""

      t.text :data, null: false, default: ""

      t.datetime :seen_at

      t.timestamps
    end
  end
end
