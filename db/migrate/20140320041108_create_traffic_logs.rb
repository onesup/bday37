class CreateTrafficLogs < ActiveRecord::Migration
  def change
    create_table :traffic_logs do |t|
      t.string :ip
      t.string :device
      t.string :referer

      t.timestamps
    end
  end
end
