class CreateRfqxEmcRfqStandards < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_rfq_standards do |t|
      t.integer :rfq_id
      t.integer :standard_id

      #t.timestamps
    end
  end
end
