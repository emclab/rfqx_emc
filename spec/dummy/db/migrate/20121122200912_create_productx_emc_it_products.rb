class CreateProductxEmcItProducts < ActiveRecord::Migration
  def change
    create_table :productx_emc_it_products do |t|
      t.integer :rfq_id
      t.string :name
      t.string :model
      t.text :tech_spec
      t.string :drawing_num

      t.timestamps
    end
  end
end
