class Refactor < ActiveRecord::Migration
  def change
    add_column :children, :parent_id, :integer
    add_index :children, :parent_id
    create_table :districts do |t|
      t.string :name
    end
    create_table :schools do |t|
      t.integer :district_id
      t.string :name
      t.timestamps
    end
    add_index :schools, :district_id
    create_table :applications do |t|
      t.integer :child_id
      t.integer :school_id
      t.integer :num
      t.timestamps
    end
    add_index :applications, :child_id
    add_index :applications, :school_id
    rename_column :children, :child_id, :egn
    rename_column :parents, :mother_id, :mother_egn
    rename_column :parents, :father_id, :father_egn
    change_column :children, :egn, :string
    change_column :parents, :mother_egn, :string
    change_column :parents, :father_egn, :string
    remove_column :parents, :mother_school, :string
    remove_column :parents, :father_school, :string
    add_column :parents, :mother_school_id, :integer
    add_index :parents, :mother_school_id
    add_column :parents, :father_school_id, :integer
    add_index :parents, :father_school_id
    remove_column :parents, :district_work, :string
    add_column :parents, :district_id, :integer
    add_index :parents, :district_id
    remove_column :children, :district_first_wish, :string
    remove_column :children, :first_wish, :string
    remove_column :children, :district_second_wish, :string
    remove_column :children, :second_wish, :string
    remove_column :children, :district_third_wish, :string
    remove_column :children, :third_wish, :string
    remove_column :children, :district_fourth_wish, :string
    remove_column :children, :fourth_wish, :string
    remove_column :children, :district_fifth_wish, :string
    remove_column :children, :fifth_wish, :string
    remove_column :children, :district, :string
    add_column :children, :district_id, :integer
    add_index :children, :district_id
  end
end
