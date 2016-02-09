require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :children
  has_many :parents

  def password
    Password.new(read_attribute :password)
  end

  def password=(new_password)
    write_attribute :password, Password.create(new_password)
  end
end
