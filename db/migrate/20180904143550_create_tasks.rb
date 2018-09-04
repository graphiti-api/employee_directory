class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.belongs_to :employee, index: true
      t.belongs_to :team, index: true
      t.string :type, index: true
      t.string :title

      t.timestamps
    end
  end
end
