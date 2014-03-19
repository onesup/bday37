class CreateViralActions < ActiveRecord::Migration
  def change
    create_table :viral_actions do |t|
      t.string :platform
      t.string :device

      t.timestamps
    end
  end
end
