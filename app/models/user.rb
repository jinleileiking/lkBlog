class User < ActiveRecord::Base
  has_many :articles
  has_many :comments
  acts_as_authentic do |c|
      c.validates_length_of_login_field_options(:within => 2 .. 100)
  end
end
