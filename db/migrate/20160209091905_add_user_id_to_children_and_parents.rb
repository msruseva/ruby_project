class AddUserIdToChildrenAndParents < ActiveRecord::Migration
  def change
    add_column :children, :user_id, :integer
    add_index :children, :user_id
    add_column :parents, :user_id, :integer
    add_index :parents, :user_id
  end
end
