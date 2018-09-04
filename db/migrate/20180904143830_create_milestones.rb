class CreateMilestones < ActiveRecord::Migration[5.2]
  def change
    create_table :milestones do |t|
      t.belongs_to :epic, index: true
      t.string :name

      t.timestamps
    end
  end
end
