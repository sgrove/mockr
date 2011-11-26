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
        puts "Got some mail!"
        puts payload.inspect
        puts event.inspect
        mail = payload[:data][:mail]
        puts "Here's the mail: #{mail.inspect}"
        # attachments = []
        # puts "collecting attachments!"
        # mail["attachment_count"].to_i.times do |counter|
        #   attachments << mail["attachment_#{counter}"]
        # end
        # attachmets.flatten!

        puts "Getting the subject:"
        subject = mail["subject"]
        puts "\tsubject: #{subject}"
        puts "Getting the project_title:"
        project_title = subject.split(":").first
        puts "\tproject_title: #{project_title}"
        puts "Getting the mock_list_title"
        mock_list_title = subject.split(":").last.split("#").first
        puts "\tmock_list_title: #{mock_list_title}"
        puts "Getting the mock_version:"
        mock_version = subject.split(":").last.split("#").last.split("comment").first.to_i
        puts "\tmock_version: #{mock_version}"
        puts "Getting the comment_id:"
        comment_id =  subject.split(":").last.split("#").last.split("comment").last.to_i
        puts "\tcomment_id: #{comment_id}"

        project = Project.find_or_create_by_title(project_title)
        puts "project: #{project.inspect}"
        mock_list = MockList.find_or_create_by_title_and_project_id(mock_list_title, project.id)
        puts "mock_list: #{mock_list.inspect}"

        mock = Mock.find(:first, :conditions => {:version => mock_version, :mock_list_id => mock_list.id})
        comment = Comment.find(comment_id) if comment_id != 0

        puts "Project:  #{project.inspect}"
        puts "MockList: #{mock_list.inspect}"
        puts "Mock:     #{mock.inspect}" if mock
        puts "Comment   #{comment.inspect}" if comment
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
