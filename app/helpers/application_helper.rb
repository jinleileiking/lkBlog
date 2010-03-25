# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_total_comments(article)
    article.comments.find(:all).length
  end
end
