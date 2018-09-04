class AddDepartmentIdToPositions < ActiveRecord::Migration[5.2]
  def change
    add_column :positions, :department_id, :integer
    add_index :positions, :department_id
  end
end
