class Page < ActiveRecord::Base
  validates_presence_of :body
  has_many :pagecontents
end
