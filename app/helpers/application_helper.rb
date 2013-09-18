require 'kramdown'

module ApplicationHelper

  def avatar_url(user,size=48)
    if user.avatar_url.present?
      user.avatar_url
    else
      default_url = asset_url('guest.png')
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=#{CGI.escape(default_url)}"
    end
  end

  def icon(i)
    content_tag :i, nil, class: "icon-#{i}"
  end

  def is_admin?
    user_signed_in?
  end

  def markdown(text)
    Kramdown::Document.new(youtube_embed(text), {
      enable_coderay: true,
      coderay_default_lang: :ruby,
      coderay_wrap: :div,
      coderay_line_numbers: :table,
      coderay_line_numbers_start: 1,
      coderay_tab_width: 2,
      coderay_css: :style,
      coderay_bold_every: 10000
    }).to_html.html_safe
  end

  def youtube_embed(str)
    output = str.lines.map do |line|
      match = nil
      match = line.match(/^http.*(?:youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*$/)

      if match
        render 'shared/youtube', locals: { video: match[1] }
      else
        line
      end
    end
    output.join
  end
end