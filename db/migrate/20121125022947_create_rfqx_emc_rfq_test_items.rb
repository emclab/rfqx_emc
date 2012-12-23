class CreateRfqxEmcRfqTestItems < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_rfq_test_items do |t|
      t.integer :rfq_id
      t.integer :test_item_id

      #t.timestamps
    end
  end
end
