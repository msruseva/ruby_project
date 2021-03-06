require File.expand_path '../spec_helper.rb', __FILE__

describe "Scoring" do
  before do
    district = District.create!(name: 'test')
    @app = Application.new(
      child: Child.new(
          parent: Parent.new(
              district: district
            ),
          district: district

        ),
      school: School.new(
          district: district
        ),
    )
  end

  it "initialize accepts an application" do
    scoring = Scoring.new(@app)
    expect(scoring).to be_a(Scoring)
    expect{Scoring.new}.to raise_error(ArgumentError)
  end

  context "apply_number" do
    it "returns proper score" do
      scoring = Scoring.new(@app)
      @app.num = 2
      expect(scoring.apply_number).to eq 4
    end

    it "returns zero if num is empty" do
      scoring = Scoring.new(@app)
      @app.num = nil
      expect(scoring.apply_number).to eq 0
    end
  end

  context "district_living" do
    it "returns zero if district of the child is not the same as district of the school" do
      scoring = Scoring.new(@app)
      @app.child.district = District.new
      expect(scoring.district_living).to eq 0
    end

    it "returns three if district of the child is the same as district of the school" do
      scoring = Scoring.new(@app)
      expect(scoring.district_living).to eq 3
    end

  end

  context "group" do
    it "returns zero if the child doesn't have certificate" do
      scoring = Scoring.new(@app)
      @app.child.group = nil
      expect(scoring.group).to eq 0
    end

    it "returns one if the child has certificate" do
      scoring = Scoring.new(@app)
      @app.child.group = true
      expect(scoring.group).to eq 1
    end
  end

  context "orphan_or_half_orphan" do
    it "returns zero if the child isn't a orphan or half_orphan" do
      scoring = Scoring.new(@app)
      @app.child.orphan = nil
      @app.child.half_orphan = nil
      expect(scoring.orphan_or_half_orphan).to eq 0
    end

    it "returns one if the child is a orphan or half_orphan" do
      scoring = Scoring.new(@app)
      @app.child.orphan = true
      @app.child.half_orphan = true
      expect(scoring.orphan_or_half_orphan).to eq 1
    end
  end

  context "parent_in_system" do
    it "returns zero if the child doesn't have a parent that works in the education system" do
      scoring = Scoring.new(@app)
      @app.child.parent_in_system = nil
      expect(scoring.parent_in_system).to eq 0
    end

    it "returns one if the child has a parent that works in the education system" do
      scoring = Scoring.new(@app)
      @app.child.parent_in_system = true
      expect(scoring.parent_in_system).to eq 1
    end
  end

  context "score" do
    it "returns true if the points from all fields are update in the database" do
      scoring = Scoring.new(@app)
      @app.child.district = District.new
      @app.child.parent.district = District.new
      @app.num = 2
      @app.child.group = true
      scoring.score
      expect(@app.reload.points).to eq 5
    end
  end
end
