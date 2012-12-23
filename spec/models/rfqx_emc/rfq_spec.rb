# encoding: utf-8
require 'spec_helper'

describe RfqxEmc::Rfq do

  it "should be OK" do
    rfq = FactoryGirl.build(:rfq)
    rfq.should be_valid
  end

  it "should not take a nil sales id" do
    rfq = FactoryGirl.build(:rfq, :sales_id => nil)
    rfq.should_not be_valid
  end

  it "should not take 0 sales id" do
    rfq = FactoryGirl.build(:rfq, :sales_id => 0)
    rfq.should_not be_valid
  end

  it "should not take a nil customer id" do
    rfq = FactoryGirl.build(:rfq, :customer_id => nil)
    rfq.should_not be_valid
  end

  it "should not take 0 customer id" do
    rfq = FactoryGirl.build(:rfq, :customer_id => 0)
    rfq.should_not be_valid
  end

  it "should not take a nil category id" do
    rfq = FactoryGirl.build(:rfq, :category_id => nil)
    rfq.should_not be_valid
  end

  it "should not take 0 category id" do
    rfq = FactoryGirl.build(:rfq, :category_id => 0)
    rfq.should_not be_valid
  end

  it "should not take a nil for need_report" do
    rfq = FactoryGirl.build(:rfq, :need_report => nil)
    rfq.should_not be_valid
  end

  it "should not have nil in report_language if need_report is true" do
    rfq = FactoryGirl.build(:rfq, :need_report => true, :report_language => nil)
    rfq.should_not be_valid
  end

  it "should be OK for nil report_language if need_report is false" do
    rfq = FactoryGirl.build(:rfq, :need_report => false, :report_language => nil)
    rfq.should be_valid

  end

  it "should not take nil customer contact name" do
    rfq = FactoryGirl.build(:rfq, :cust_contact_name => nil)
    rfq.should_not be_valid
  end
  
  it "should return rfqs by find_rfqs with matching product name" do
    prod = ProductxEmcIt::Product.create(:name => 'prod', :model => 'abd')
    rfq = FactoryGirl.create(:rfq, :product => prod)
    rfq_s = RfqxEmc::Rfq.new({:keyword => 'prod'}, :as => :role_search)
    rfq_s.find_rfqs.should eq([rfq])
  end
  
  it "should return rfqs by find_rfqs with matching standard_id" do
    pending 
  end

end