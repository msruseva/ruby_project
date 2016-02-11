class SchoolClassification

  attr_accessor :position

  def initialize(school_id)
    @school_id = school_id
    @position = 1
  end

  def classifing
    Application.where(school_id: @school_id).order("points DESC").each do |app|
      app.classifing = true
      app.num_classifing = @position
      app.save
      @position += 1
      break if @position > School::PLACES
    end
  end
end
