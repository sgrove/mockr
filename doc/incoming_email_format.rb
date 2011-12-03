# Incoming email command format

# Add/reply to a comment
{
  :subject => "#{project_title}: #{mockr_list.title} ##{mock.version} comment #{comment.id}",
  :body => "#{comment}"
}

# Add a new version
# Subject is the title of existing mock_list
{
  :subject => "#{project_title}: #{mockr_list.title}",
  :body => "#{mock.description}",
  :attachment => "#{mock.image}"
}

# Create a new mock_list
# Mock list is a new title
# Also creates a new mock 
{
  :subject => "#{project_title}: #{mockr_list.title}",
  :body => "#{mock.description}",
  :attachment => "#{mock.image}"
}

# Create a new project
# Project is a new title
# Also creates a new mock list and mock
{
  :subject => "#{project_title}: #{mockr_list.title}",
  :body => "#{mock.description}",
  :attachment => "#{mock.image}"
}

# Any email address included in the body of the incoming email will automatically be subscribed to updates about the given mock and all following iterations
