require File.expand_path "../spec_helper.rb", __FILE__

describe "SchoolClassification" do
  before do

    @school = School.create!(
      district: District.new(name: "Gorna banya"),
      name: "22ro"
    )

    @user = User.create!

    @parent = Parent.create!(
      mother_egn: "1234567890",
      mother_first_name: "Totka",
      mother_second_name: "Georgieva",
      mother_last_name: "Milic",
      user: @user
    )

    @district = District.create!

    @app1 = Application.create!(
      school: @school,
      child: Child.create!(
        user: @user,
        parent: @parent,
        egn: "9876543210",
        first_name: "Stefan",
        second_name: "Ivanov",
        last_name: "Petrov",
        district: @district
      ),
      num: 1,
      points: 3
    )

    @app2 = Application.create!(
      school: @school,
      child: Child.create!(
        user: @user,
        parent: @parent,
        egn: "9876553210",
        first_name: "Viktoriq",
        second_name: "Ivanov",
        last_name: "Petrova",
        district: @district
      ),
      num: 1,
      points: 2
    )

    @app3 = Application.create!(
      school: @school,
      child: Child.create!(
        user: @user,
        parent: @parent,
        egn: "9876553310",
        first_name: "Angel",
        second_name: "Ivanov",
        last_name: "Petrov",
        district: @district
      ),
      num: 1,
      points: 1
    )
  end

  it "initialize accepts a school" do
    school_classified = SchoolClassification.new(@school.id)
    expect(school_classified.position).to eq 1
    expect(school_classified).to be_a(SchoolClassification)
    expect{SchoolClassification.new}.to raise_error(ArgumentError)
  end

  context "classifing" do
    it "returns true if child was classified in school" do
      School::PLACES = 2
      school_classified = SchoolClassification.new(@school.id)
      school_classified.classifing
      expect(@app1.reload.classifing).to be true
    end

    it "returns nil if child was not classified" do
      School::PLACES = 2
      school_classified = SchoolClassification.new(@school.id)
      school_classified.classifing
      expect(@app3.reload.classifing).to be nil
    end

    it "returns one if child was classified in his first wish" do
      School::PLACES = 2
      school_classified = SchoolClassification.new(@school.id)
      school_classified.classifing
      @app1.reload.classifing = true
      expect(@app1.num_classifing).to eq 1
    end

    it "returns the places for one school" do
      School::PLACES = 2
      school_classified = SchoolClassification.new(@school.id)
      school_classified.classifing
      expect(@school.classified.size).to eq 2
    end
  end
end
