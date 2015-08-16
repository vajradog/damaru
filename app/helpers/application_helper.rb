module ApplicationHelper
  def mins_count(post)
    (post.body.to_s.split.size  / 214).round
  end

  def fix_date(t)
    t.strftime("%A, %B %d, %Y")
  end
end



