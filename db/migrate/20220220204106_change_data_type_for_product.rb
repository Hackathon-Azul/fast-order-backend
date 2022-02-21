class ChangeDataTypeForProduct < ActiveRecord::Migration[6.0]
  def up
    change_column :products, :price, :float
  end

  def down
      change_column :products, :price, :decimal
  end
end
