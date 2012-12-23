class CreateRfqxEmcRfqs < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_rfqs do |t|
      t.date :rfq_date
      t.integer :sales_id
      t.integer :customer_id
      t.integer :safety_eng_id
      t.integer :emc_eng_id
      t.integer :last_updated_by_id
      t.boolean :active, :default => true
      t.date :start_date
      t.date :finish_date
      t.boolean :need_report, :default => true
      t.string :report_language
      t.boolean :top_secret, :default => false
      t.integer :category_id
      t.string :cust_contact_name
      t.string :cust_contact_phone
      t.text :note

      t.timestamps
    end
  end
end
