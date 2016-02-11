class Parents < ActiveRecord::Migration
  def self.up
    create_table :parents do |t|
      t.integer :mother_id
      t.string :mother_first_name
      t.string :mother_second_name
      t.string :mother_last_name

      t.integer :father_id
      t.string :father_first_name
      t.string :father_second_name
      t.string :father_last_name

      t.string :district_work
      t.string :mother_school
      t.string :father_school

    end
  end

  def self.down
    drop_table :parents
  end
end
