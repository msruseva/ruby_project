class School < ActiveRecord::Base
  belongs_to :district
  has_many :applications

  PLACES = 130

  def self.by_district
    result = {}
    School.order(:name).each do |school|
      result[school.district_id] ||= []
      result[school.district_id] << {id: school.id, name: school.name}
    end
    result
  end

  def classified
    applications.where(classifing: true).order(:num_classifing)
  end
end
