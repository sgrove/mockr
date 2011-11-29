class BushidoEmailHooks < Bushido::EventObserver
  def mail_new_comment
    mock   = Mock.find(:first, :conditions => {:title => params['mock_title'], :version => params['mock_version']})
    parent = Comment.find(params['parent_comment_id'])
    author = User.find_by_email(params['from_email']) || User.first

    Comment.create!(:author_id => author_id, :parent_id => parent_comment.id, :text => params['mail']['stripped-text'], :mock_id => mock.id)
  end

  def mail_new_mock
    handle_new_mock(params)
  end

  def mail_new_project
    handle_new_mock(params)
  end

  def mail_simple
    puts "YAY!"
    puts params.inspect
  end

  private

  def handle_new_mock(params)
    project        = Project.find_or_create_by_title(params['project_title'])
    mock_list      = MockList.find_or_create_by_title_and_project_id(params['mock_list_title'], project.id)
    mock           = Mock.find(:first, :conditions => {:title => params['mock_title'], :mock_list_id => mock_list.id})

    Mock.new.create(:mock.title       = mock_list.title,
                    :mock.description = params['mail']['stripped-text'],
                    :mock.mock_list   = mock_list,
                    :mock.author_id   = User.find_by_email(params['from_email']) || User.find(1).id,
                    :mock.image       = params['attachments'].first,
                    :mock.path        = "") if mock.nil?
  end
end
