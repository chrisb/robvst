module PageTitleHelper

  def html_title(content)
    return Robvst::Application.config.blog[:name] if params[:controller] == 'pages' || devise_controller?

    if content.present?
      [content,current_blog.title].join(' - ')
    else
      current_blog.title
    end
  end

  def page_title(content)
    return 'robvst' if params[:controller] == 'pages'
    @title = content || current_blog.title
    render partial: 'name'
  end

  def linked_title
    link_to current_blog.title, root_path
  end

end