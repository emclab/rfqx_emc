class CreateRfqxEmcCategories < ActiveRecord::Migration
  def change
    create_table :rfqx_emc_categories do |t|
      t.string :name
      t.string :description
      t.integer :last_updated_by_id
      t.boolean :active, :default => true

      t.timestamps
    end
  end
end
