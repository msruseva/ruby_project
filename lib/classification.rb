class Classification

  def self.run
    Application.where(points: nil).each do |app|
      Scoring.new(app).score
    end
    Application.update_all(classifing: false, num_classifing: nil)
    Application.select(:shool_id).distinct.each do |school_id|
      SchoolClassification.new(school_id).classifing
    end
  end

end
