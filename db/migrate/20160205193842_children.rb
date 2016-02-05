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

      t.string :first_wish
      t.string :second_wish
      t.string :third_wish
      t.string :forth_wish
      t.string :fifth_wish
    end
  end

  def self.down
    drop_table :children
  end
end
