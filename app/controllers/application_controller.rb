class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :resolve_subdomain
  before_filter :get_user
  before_filter :configure_permitted_parameters, if: :devise_controller?

  helper_method :no_users?, :blog_config

  layout :resolve_layout

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found

  # unless Rails.configuration.consider_all_requests_local
  #   rescue_from Exception, :with => :render_error
  #   rescue_from ::ActionController::RoutingError,       with: :render_not_found
  #   rescue_from ::ActionController::UnknownController,  with: :render_not_found
  #   rescue_from ::ActionController::UnknownAction,      with: :render_not_found
  # end

  def blog_config
    Robvst::Application.config.blog
  end

  def url_host
    user_signed_in? ? "#{current_user.subdomain}.#{blog_config[:domain]}" : request.host
  end

  def default_url_options
    user_signed_in? ? super.merge({ :host => url_host, :only_path => false, }) : super
  end

  def no_users?
    User.all.count == 0
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def render_not_found(exception)
    logger.error "404 Not Found"
    logger.error exception
    render template: 'errors/404', status: 404 unless @not_found
  end

  def render_error(exception)
    logger.error "500 Internal Server Error"
    logger.error exception
    render template: 'errors/500', status: 500 unless @not_found
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :name, :password, :password_confirmation, :subdomain) }
    end

    def current_blog
      @current_blog
    end

    def resolve_subdomain
      return if request.subdomains.empty? || request.subdomains.include?('www')
      @current_blog = User.find_by_subdomain(request.subdomains.last)
      redirect_to root_url(host:Robvst::Application.config.blog[:domain]) unless @current_blog.present?
    end

    def resolve_layout
      devise_controller? || params[:controller] == 'pages' ? 'network' : 'application'
    end

  private

    def get_user
      @user = current_user || User.new
    end

end