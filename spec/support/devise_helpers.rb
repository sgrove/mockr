def login_user
  request.env['warden'].stub(:authenticate!) { double(User) }
end

