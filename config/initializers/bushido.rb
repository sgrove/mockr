def on_bushido?
  return false if ENV['BUSHIDO_APP_KEY'].nil?
  true
end

if on_bushido?
  puts "BUSHIDO APP KEY: #{ENV['BUSHIDO_APP_KEY']}"
end
