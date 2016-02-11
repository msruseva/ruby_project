class Scoring

  attr_accessor :points

  def initialize(app)
    @app = app
    @points = 0
  end

  def apply_number
    @points += case @app.num
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

    @points += 1 if district_child == district_school
  end

  def parent_district_work
    district_parent = @app.child.parent.district.id
    district_school = @app.school.district.id

    @points += 1 if district_parent == district_school
  end

  def group
    @points += 1 if @app.child.group
  end

  def orphan
    @points += 1 if @app.child.orphan
  end

  def half_orphan
    @points += 1 if @app.child.half_orphan
  end

  def parent_in_system
    @points += 1 if @app.child.parent_in_system
  end

  def score
    apply_number
    district_living
    parent_district_work
    group
    orphan
    half_orphan
    parent_in_system
    @app.points = @points
    @app.save
  end
end
