class BushidoEmailHooks < Bushido::EventObserver
  def mail_new_comment
    mock   = Mock.find(:first, :conditions => {:title => params['mock_title'], :version => params['mock_version']})
    parent = Comment.find(params['parent_comment_id'])
    author = User.find_by_email(params['from_email']) || User.first

    comment = Comment.new
    comment.author_id = author.id
    comment.parent_id = parent.id
    comment.text = params['mail']['stripped-text']
    comment.mock_id = mock.id
    comment.save
  end

  def mail_new_mock
    puts "Handling new mock"
    handle_new_mock(params)
  end

  def mail_new_project
    puts "Handling new project"
    handle_new_mock(params)
  end

  def mail_simple
    puts "YAY!"
    puts params.inspect
  end

  private

  def handle_new_mock(params)
    puts "Handling new mock with #{params.inspect}"
    project        = Project.find_or_create_by_title(params['project_title'])
    mock_list      = MockList.find_or_create_by_title_and_project_id(params['mock_title'], project.id)
    mock           = Mock.find(:first, :conditions => {:title => params['mock_title'], :mock_list_id => mock_list.id})

    puts 
    if mock.nil?
      puts "Creating a new mock"
      # mock = Mock.create(:title       => mock_list.title,
      #                    :description => params['mail']['stripped-text'],
      #                    :mock_list   => mock_list,
      #                    :author_id   => User.find_by_email(params['from_email']) || User.find(1).id,
      #                    :image       => params['mail']['attachments'].first,
      #                    :path        => "")

      mock = Mock.new
      mock.title       = mock_list.title
      mock.description = params['mail']['stripped-text']
      mock.mock_list   = mock_list
      mock.author_id   = User.find_by_email(params['from_email']) || User.find(1).id
      mock.image       = params['mail']['attachments'].first
      mock.path        = ""

      puts mock.inspect
      mock.save
      puts "finished!"
      puts mock.inspect
    end
  end
end
