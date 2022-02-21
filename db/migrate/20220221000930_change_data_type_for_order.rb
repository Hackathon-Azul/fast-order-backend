class ChangeDataTypeForOrder < ActiveRecord::Migration[6.0]
  def up
    change_column :orders, :total, :float
  end

  def down
      change_column :orders, :total, :decimal
  end
end
