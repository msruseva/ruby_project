class Application < ActiveRecord::Base
  belongs_to :child
  belongs_to :school

  validates :child, :school, :num, presence: true


end
