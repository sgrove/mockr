class MockObserver < ActiveRecord::Observer

  def after_create(mock)
    notify_users(mock)
  end

  def after_update(mock)
    notify_users(mock)
  end

  private
  
  def notify_users(mock)
    Notifier.deliver_new_mock(mock)
  end
end
