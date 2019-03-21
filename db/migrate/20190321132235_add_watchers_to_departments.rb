class AddWatchersToDepartments < ActiveRecord::Migration[5.2]
  def change
    add_column :departments, :watcher_emails, :text, default: '[]'
  end
end
