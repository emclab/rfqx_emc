FactoryGirl.define do
  factory :category, class: 'RfqxEmc::Category' do
    name "a emc rfq category"
    description "details about a emc category"
    active true
    last_updated_by_id 1
  end
end