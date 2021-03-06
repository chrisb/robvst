class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show, :admin]
  layout 'admin', except: [:index, :show]

  def index
    @posts = Post.by(current_blog).published.newest.page(params[:page]).per(8)

    respond_to do |format|
      format.html
      format.xml { render xml: @posts }
      format.rss { render layout: false }
    end
  end

  def show
    @single_post = true
    @post         = Post.by(current_blog).where(slug:params[:id]).first || not_found

    not_found if @post.draft and !user_signed_in?

    @next     = Post.by(current_blog).next(@post).last
    @previous = Post.by(current_blog).previous(@post).first

    respond_to do |format|
      if @post.present?
        format.html
        format.xml { render xml: @post }
      else
        format.any { render status: 404  }
      end
    end
  end

  def admin
    if user_signed_in?
      @no_header = true
      @post      = Post.new
      @published = Post.by(current_user).where(draft:false).order('published_at desc')
      @drafts    = Post.by(current_user).where(draft:true).order('updated_at desc')
    else
      redirect_to new_user_session_url(host:blog_config[:domain])
    end
  end

  def new
    @post = Post.new(title: params[:title] || '')
    @post_path = '/'

    respond_to do |format|
      format.html
    end
  end

  def edit
    @post = Post.where(slug: params[:id], user: current_user).first
    @post_path = post_path(@post)
  end

  def create
    @post = Post.new(params.require(:post).permit!)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to "/edit/#{@post.id}", notice: "Post created successfully" }
        format.xml { render xml: @post, status: :created, location: @post }
        format.text { render text: @post.to_json }
      else
        format.html { render action: 'new' }
        format.xml { render xml: @post.errors, status: :unprocessable_entity}
        format.text { head :bad_request }
      end
    end
  end

  def update
    @post = params[:id].to_i.to_s == params[:id] ? Post.find(params[:id]) : Post.find_by_slug(params[:id])
    raise "cant" unless @post.user == current_user
    logger.info @post

    respond_to do |format|
      if @post.update_attributes(params.require(:post).permit!)
        format.html { redirect_to "/edit/#{@post.id}", notice: "Post updated successfully" }
        format.xml { head :ok }
        format.text { render text: @post.to_json }
      else
        format.html { render action: 'edit' }
        format.xml { render xml: @post.errors, status: :unprocessable_entity}
        format.text { head :bad_request }
      end
    end
  end

  def destroy
    @post = Post.find_by_slug(params[:id])
    raise "cant" unless @post.user == current_user
    @post.destroy
    flash[:notice] = 'Post has been deleted'

    respond_to do |format|
      format.html { redirect_to '/admin' }
      format.xml { head :ok }
    end
  end

  private

    def admin?
      session[:admin] == true
    end

end