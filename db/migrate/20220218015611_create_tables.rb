class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.integer :table_number
      t.boolean :avaliable_table

      t.timestamps
    end
  end
end
