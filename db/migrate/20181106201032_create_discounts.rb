class CreateDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :discounts do |t|
      t.integer :range_low
      t.integer :range_high
      t.float :percent
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
