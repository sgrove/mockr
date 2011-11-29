class BushidoUserHooks < Bushido::EventObserver
  def user_added
    user.create(:email  => params['data']['email'],
                :ido_id => params['data']['ido_id'])
  end

  def user_removed
    User.find_by_ido_id(params['data']['ido_id']).try(:destroy)
  end
end
