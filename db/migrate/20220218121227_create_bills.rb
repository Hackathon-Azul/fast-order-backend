class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.references :order, null: false, foreign_key: true
      t.boolean :status_bill

      t.timestamps
    end
  end
end
