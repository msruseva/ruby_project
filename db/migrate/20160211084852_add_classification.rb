class AddClassification < ActiveRecord::Migration
  def change

    add_column :applications, :points, :integer
    add_column :applications, :num_classifing, :integer
    add_column :applications, :classifing, :boolean

  end
end
