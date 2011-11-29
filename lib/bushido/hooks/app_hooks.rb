class BushidoAppHooks < Bushido::EventObserver
  def app_claimed
    User.find(1).update(:email  => params['data']['email'],
                        :ido_id => params['data']['ido_id'])
  end
end
