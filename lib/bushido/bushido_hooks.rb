module MockrBushido
  class MockrHooks
    def self.subscribe_to_events
     print "Subscribing to app.claimed..."
      ::Bushido::Data.listen('app.claimed') do |payload, event|
        data = payload["data"]
        puts "Data: #{data.inspect} (#{data.class})"
        puts "Event: #{event.inspect} (#{event.class})"
        user = User.find(1)
        user.email = data['email']
        user.ido_id = data['ido_id']
        user.save
      end
     puts "done"

     print "Subscribing to user.added..."
      ::Bushido::Data.listen('user.added') do |payload, event|
        data = payload["data"]
        puts "Adding a new account with incoming data #{event.inspect}"
        puts "Devise username column: #{::Devise.cas_username_column}="
        puts "Setting username to: #{payload['data'].try(:[], 'ido_id')}"

        user = User.new
        user.email = data['email']
        user.ido_id = data['ido_id']
        user.save
      end
     puts "done"

     print "Subscribing to user.removed..."
      ::Bushido::Data.listen('user.removed') do |payload, event|
        puts "Removing account based on incoming data #{event.inspect}"
        puts "Devise username column: #{::Devise.cas_username_column}="
        puts "Removing username: #{payload['data'].try(:[], 'ido_id')}"

        ido_id = payload['data'].try(:[], 'ido_id')

        user = User.find_by_ido_id(ido_id)
        user.destroy
      end
     puts "done"
    end
  end
end

if Devise.on_bushido?
  puts "Subscribing to bushido events!"
  MockrBushido::MockrHooks.subscribe_to_events
else
  puts "Not on bushido, not subscribing!"
end
