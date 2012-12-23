module RfqxEmc
  class RfqStandard < ActiveRecord::Base
    attr_accessible :rfq_id, :standard_id
    belongs_to :rfq
    belongs_to :standard, :class_name => 'TestItemx::Standard'
  
    validates_numericality_of :standard_id, :greater_than => 0
    validates :standard_id, :uniqueness => { :scope => :rfq_id }
  end
end
