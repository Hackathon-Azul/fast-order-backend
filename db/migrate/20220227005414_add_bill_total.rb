class AddBillTotal < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :total, :float
  end
end
