class Application < ActiveRecord::Base
  belongs_to :child
  belongs_to :school

  validates :child, :school, :num, presence: true

  before_validation do
    return if self.num.present?
    self.num = child.applications.maximum(:num).to_i + 1 if child.present?
  end
end
