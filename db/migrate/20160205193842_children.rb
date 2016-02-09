class Children < ActiveRecord::Migration
  def self.up
    create_table :children do |t|

      t.integer :child_id
      t.string :first_name
      t.string :second_name
      t.string :last_name

      t.string :district
      t.string :group
      t.string :orphan
      t.string :half_orphan
      t.string :parent_in_system

      t.string :district_first_wish
      t.string :first_wish

      t.string :district_second_wish
      t.string :second_wish

      t.string :district_third_wish
      t.string :third_wish

      t.string :district_fourth_wish
      t.string :fourth_wish

      t.string :district_fifth_wish
      t.string :fifth_wish

    end
  end

  def self.down
    drop_table :children
  end

end
