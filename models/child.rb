class Child < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent
  belongs_to :district
  has_many :applications, dependent: :destroy

  validates :egn, :first_name, :second_name, :last_name, :district_id,
    :user, :parent, presence: true
  validates :egn, length: { is: 10 }

  def to_s
    "#{first_name} #{last_name}"
  end
end
