class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  mount_uploader :background, BackgroundUploader
end