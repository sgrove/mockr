class MockObserver < ActiveRecord::Observer

  def after_update(mock)
    notify_users(mock)
  end

  private
  
  def notifiy_users(mock)
    Notifier.deliver_new_mock(self)
  end
end
