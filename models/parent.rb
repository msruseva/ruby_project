class Parent < ActiveRecord::Base
  belongs_to :user
  has_many :children

  validates :mother_egn, :mother_first_name, :mother_second_name,
    :mother_last_name, :user, presence: true
  validates :mother_egn, :father_egn, length: { is: 10 }
end
