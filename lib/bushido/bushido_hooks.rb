module MockrBushido
  class MockrHooks
    def self.subscribe_to_events
      ::Bushido::Data.listen('app.claimed') do |payload, event|
        data = payload["data"]

        user = User.find(1)
        user.email = data['email']
        user.ido_id = data['ido_id']
        user.save
      end


      ::Bushido::Data.listen('user.added') do |payload, event|
        data = payload["data"]

        user = User.new
        user.email = data['email']
        user.ido_id = data['ido_id']
        user.save
      end


      ::Bushido::Data.listen('user.removed') do |payload, event|
        ido_id = payload['data'].try(:[], 'ido_id')

        user = User.find_by_ido_id(ido_id)
        user.destroy
      end


      ::Bushido::Data.listen('mail.received') do |payload, event|
        mail = payload["mail"]
        attachments = []
        mail["attachment_count"].to_i.times do |counter|
          attachments << mail["attachment_#{counter}"]
        end
        attachmets.flatten!

        subject = mail["subject"]
        project_title = subject.split(":").first
        mock_list_title = subject.split(":").last.split("#").first
        mock_version = subject.split(":").last.split("#").last.split("comment").first.to_i
        comment_id =  subject.split(":").last.split("#").last.split("comment").last.to_i

        project = Project.find_or_create_by_title project_title
        mock_list = Project.mock_lists.find_or_create_by_title mock_list_title

        mock = mock_list.mocks.find_by_version mock_version if mock_version != 0
        comment = mock.comments.find(comment_id) if comment_id != 0

        puts "Project:  #{project.inspect}"
        puts "MockList: #{mock_list.inspect}"
        puts "Mock:     #{mock.inspect}"
        puts "Comment   #{comment.inspect}"
      end
    end
  end
end

if Devise.on_bushido?
  puts "Subscribing to bushido events!"
  MockrBushido::MockrHooks.subscribe_to_events
else
  puts "Not on bushido, not subscribing!"
end
