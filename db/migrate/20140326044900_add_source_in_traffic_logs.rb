class AddSourceInTrafficLogs < ActiveRecord::Migration
  def change
    add_column :traffic_logs, :source, :string
  end
end
