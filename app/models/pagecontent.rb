class Pagecontent < ActiveRecord::Base
    validates_presence_of :body
  belongs_to :page
end
