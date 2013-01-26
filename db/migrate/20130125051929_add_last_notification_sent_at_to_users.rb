class AddLastNotificationSentAtToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
    	t.datetime :last_notification_sent_at
    end
  end
end
