class AddEmailToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :email, :string
  end
end
