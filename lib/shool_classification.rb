class SchoolClassification

  attr_accessor :possition

  def initialize(school_id)
    @school_id = school_id
    @possition = 1
  end

  def classifing
    Application.where(school_id: school_id).order(:points).each do |app|
      app.classifing = true
      app.num_classification = @possition
      app.save
      @possition += 1
      break if @possition >= School::PLACES
    end
  end
end
