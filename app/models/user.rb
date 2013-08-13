class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name
  validates_presence_of :subdomain
  validates_uniqueness_of :subdomain

  before_create :generate_subdomain

  protected

    def generate_subdomain
      return if subdomain.present?
      self.subdomain = name.to_s.parameterize
      i = 0
      while User.exists?(subdomain:self.subdomain) do
        self.subdomain = "#{name.parameterize}-#{i+=1}"
      end
    end

end
