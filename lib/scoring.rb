class Scoring

  attr_accessor :points

  def initialize(app)
    @app = app
  end

  def apply_number
    case @app.num
      when 1 then 5
      when 2 then 4
      when 3 then 3
      when 4 then 2
      when 5 then 1
      else 0
    end
  end

  def district_living
    district_child = @app.child.district.id
    district_school = @app.school.district.id

    district_child == district_school ? 1 : 0
  end

  def parent_district_work
    district_parent = @app.child.parent.district.id
    district_school = @app.school.district.id

    district_parent == district_school ? 1 : 0
  end

  def group
    @app.child.group == "t" ? 1 : 0
  end

  def orphan
    @app.child.orphan == "t" ? 1 : 0
  end

  def half_orphan
    @app.child.half_orphan == "t" ? 1 : 0
  end

  def parent_in_system
    @app.child.parent_in_system == "t" ? 1 : 0
  end

  def score
    @app.points = apply_number + district_living + parent_district_work + group + orphan + half_orphan + parent_in_system
    @app.save
  end
end


