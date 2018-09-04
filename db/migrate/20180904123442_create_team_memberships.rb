class CreateTeamMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :team_memberships do |t|
      t.belongs_to :team, index: true
      t.belongs_to :employee, index: true

      t.timestamps
    end
  end
end
