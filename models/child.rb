class Child < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent
  has_many :applications, dependent: :destroy

  validates :egn, :first_name, :second_name, :last_name,
    :user, :parent, presence: true
  validates :egn, length: { is: 10 }

  def to_s
    "#{first_name} #{last_name}"
  end
end
