require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  def password
    Password.new(read_attribute :password)
  end

  def password=(new_password)
    write_attribute :password, Password.create(new_password)
  end
end
