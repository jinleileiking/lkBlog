class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_attached_file :photo
end
