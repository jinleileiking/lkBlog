class Article < ActiveRecord::Base
  validates_presence_of :body, :title
  validates_uniqueness_of :title
  belongs_to :user
  has_many :comments
  has_attached_file :photo
end
