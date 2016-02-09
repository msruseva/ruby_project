class School < ActiveRecord::Base
  belongs_to :district
  has_many :applications

  def self.by_district
    result = {}
    School.order(:name).each do |school|
      result[school.district_id] ||= []
      result[school.district_id] << {id: school.id, name: school.name}
    end
    result
  end
end