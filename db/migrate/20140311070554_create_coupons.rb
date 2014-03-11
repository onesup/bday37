class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references :user, index: true
      t.references :message, index: true
      t.string :code
      t.string :status, default: "not_used"
      t.datetime :used_at

      t.timestamps
    end
  end
end
