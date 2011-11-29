class CommentObserver < ActiveRecord::Observer

  def after_create(comment)
    puts "Checking for new comments to email out"

    discussions = MockView.discussions_relevant_to(comment)

    discussions.each do |discussion|
      discussion.reply_count += 1
      discussion.last_replied_at = comment.created_at
      discussion.save!
    end

    Notifier.deliver_new_comment(comment) if comment.recipient_emails.any?
  end
end
