class Notifier < ActionMailer::Base
  helper ApplicationHelper

  # TODO: fix this
  REPLY_TO = Bushido::Platform.on_bushido? ? "#{ENV['SMTP_USER']}" : "do-not-reply@mockr.gobushido.com"

  def new_comment(comment)
    puts "Sending out email for comment!"
    from REPLY_TO
    reply_to REPLY_TO
    subject mock_subject(comment.mock, comment)
    recipients comment.recipient_emails
    content_type "text/html"

    if comment.has_selection?
      puts "comment has selection!"
      attachment :body => comment.selection_image,
                 :content_type => "image/png",
                 :filename => "#{comment.mock.title}_#{comment.id}.png"
    end

    body :comment => comment
  end  
  
  def new_mock(mock, recipients = nil)
    puts "Sending out email for mock!"
    host = self.class.default_url_options[:host]

    from REPLY_TO
    recipients ||= Setting[:notification_email] || User.find(1).email
    reply_to REPLY_TO
    subject mock_subject(mock)
    recipients recipients
    attachment :body => mock.attachment_body,
               :content_type => "image/png",
               :filename => "#{mock.title}.png"
    part :body => render_message("new_mock", :host => host, :mock => mock),
         :content_type => "text/html"
  end
  
  private
  
  def mock_subject(mock, comment=nil)
    # Use the comment's parent id if it's present
    comment_id = (comment.parent_id || comment.id) if comment

    base = "#{mock.project.title}: #{mock.mock_list.title} ##{mock.id}"
    base += " comment #{comment_id}" if comment_id
    base
  end  
end
