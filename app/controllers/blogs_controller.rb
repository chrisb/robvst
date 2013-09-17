class BlogsController < ApplicationController
  before_filter :validate_access!

  # GET /blogs/1/edit
  def edit
    background_url = current_blog.background_url
  end

  # PATCH/PUT /blogs/1
  def update

    # Determine dominant colors in the uploaded file.
    if params[:blog][:background].is_a?(ActionDispatch::Http::UploadedFile)
      session[:background_colors] = Miro::DominantColors.new(params[:blog][:background].path).to_hex
    end

    if current_blog.update(blog_params)
      redirect_to root_path, notice: 'Blog was successfully updated.'
    else
      render action: 'edit'
    end
  end


  private

    def validate_access!
      redirect_to root_path unless current_user == current_author
    end

    # Only allow a trusted parameter "white list" through.
    def blog_params
      params.require(:blog).permit(:user_id, :title, :background, :background_color)
    end

end
