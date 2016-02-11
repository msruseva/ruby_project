class CheckBoxesType < ActiveRecord::Migration
  def change
    change_column :children, :group, :boolean
    change_column :children, :orphan, :boolean
    change_column :children, :half_orphan, :boolean
    change_column :children, :parent_in_system, :boolean
  end
end
