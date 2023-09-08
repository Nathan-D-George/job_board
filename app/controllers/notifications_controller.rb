class NotificationsController < ApplicationController
  def list
     @notifications = Notification.all.order(id: :desc)
  end

end
