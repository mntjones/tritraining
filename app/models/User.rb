class User < ActiveRecord::Base
	
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email

  def slug
    self.username.split(' ').join('-')
  end

  def self.find_by_slug(slug)
    self.all.select do |user|
      user.slug == slug
    end.first
  end
end