class CreatePositions < ActiveRecord::Migration[5.2]
  def change
    create_table :positions do |t|
      t.belongs_to :employee, index: true

      t.string :title
      t.integer :historical_index
      t.boolean :active

      t.timestamps
    end
  end
end
