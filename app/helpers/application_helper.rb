# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def get_total_comments(article)
    article.comments.find(:all).length
  end

  def is_showable(article, user)
    if article.isShare == true
      return true
    end

    if user
      if user.isAdmin == true
        return true
      end
    end

    return false
  end
end
