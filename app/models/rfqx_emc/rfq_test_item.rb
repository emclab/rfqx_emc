module RfqxEmc
  class RfqTestItem < ActiveRecord::Base
    attr_accessible :rfq_id, :test_item_id
    belongs_to :rfq
    belongs_to :test_item, :class_name => 'TestItemx::TestItem'

    validates_numericality_of :test_item_id, :greater_than => 0
    validates :test_item_id, :uniqueness => { :scope => :rfq_id } 
  end
end
