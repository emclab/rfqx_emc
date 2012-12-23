# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rfqx_emc_rfq_standard, :class => 'RfqStandard' do
    rfq_id 1
    standard_id 1
  end
end
