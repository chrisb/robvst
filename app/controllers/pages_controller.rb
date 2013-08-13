class PagesController < ApplicationController

  layout 'network'

  def index
    redirect_to posts_url if user_signed_in?
  end

end