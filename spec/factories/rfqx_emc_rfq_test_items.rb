# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rfqx_emc_rfq_test_item, :class => 'RfqTestItem' do
    rfq_id 1
    test_item_id 1
  end
end
