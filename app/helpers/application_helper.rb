module ApplicationHelper

  #return title on per page basis
  def title
    base_title = "Score-App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
