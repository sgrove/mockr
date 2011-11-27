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


      ::Bushido::Data.listen('mail.received') do |mail, event|
        puts "Got some mail!"
        puts "Here's the mail: #{mail.inspect}"
        puts event.inspect

        # See to experiment with pattern: http://rubular.com/r/sEz3lCWHLb
        command_pattern = p = /^(Re:\s)?([a-z\-_0-9 ]*):[[\s]*]?([\w|\s_*!~@$-]*)?[[\s]*]?#?(\d*)[[\s]*]?[comment]*[[\s]*]?(\d*)$/i

        result = command_pattern.match(mail["subject"])

        puts command_pattern.inspect
        puts mail["subject"]
        puts result.inspect

        reply           = !result[1].blank?
        project_title   =  result[2]
        mock_list_title =  result[3]
        mock_id         =  result[4].to_i
        comment_id      =  result[5].to_i

        puts "Getting the project_title:"
        puts "\tproject_title: #{project_title}"
        puts "Getting the mock_list_title"
        puts "\tmock_list_title: #{mock_list_title}"
        puts "Getting the mock_id:"
        puts "\tmock_id: #{mock_id}"
        puts "Getting the comment_id:"
        puts "\tcomment_id: #{comment_id}"

        project = Project.find_or_create_by_title(project_title)
        puts "project: #{project.inspect}"
        mock_list = MockList.find_or_create_by_title_and_project_id(mock_list_title, project.id)
        puts "mock_list: #{mock_list.inspect}"

        mock = Mock.find(:first, :conditions => {:id => mock_id}) if mock_id != 0
        parent_comment = Comment.find(comment_id) if comment_id != 0

        puts "Project:  #{project.inspect}"
        puts "MockList: #{mock_list.inspect}"
        puts "Mock:     #{mock.inspect}" if mock
        puts "Comment   #{parent_comment.inspect}" if parent_comment


        # Start from the end and work our way back

        # Handle replying to a comment/mock
        if mock and mail["attachments"].empty?
          comment = Comment.new
          puts "User should be the correct email #{mail['from']} or #{mail['sender']}..."
          comment.author_id = User.find_by_email(mail["sender"]) || User.find(1).id
          comment.parent_id = parent_comment.id if parent_comment
          comment.text = mail["stripped-text"]
          comment.mock = mock
          comment.save
        end

        # Handle creating a new version of an existing mock
        if mock.nil?
          mock = Mock.new
          mock.title = mock_list_title
          mock.description = mail["stripped-text"]
          mock.mock_list = mock_list
          mock.author_id = User.find_by_email(mail["sender"]) || User.find(1).id
          mock.image = mail["attachments"].first
          mock.path = ""
          mock.save
        end
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
