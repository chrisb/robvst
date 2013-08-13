module PageTitleHelper

  def html_title(content)
    return Robvst::Application.config.blog[:name] if params[:controller] == 'pages' || devise_controller?

    if content.present?
      [content,current_blog.name].join(' - ')
    else
      current_blog.name
    end
  end

  def page_title(content)
    return 'robvst' if params[:controller] == 'pages'
    @title = content || current_blog.name
    render partial: 'name'
  end

  def linked_title
    link_to current_blog.name, root_path
  end

end