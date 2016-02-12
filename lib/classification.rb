class Classification

  def self.run
    Application.update_all(points: nil, classifing: false, num_classifing: nil)
    Application.where(points: nil).each do |app|
      Scoring.new(app).score
    end
    Application.all.each do |app|
      SchoolClassification.new(app[:school_id]).classifing
    end
  end

end
