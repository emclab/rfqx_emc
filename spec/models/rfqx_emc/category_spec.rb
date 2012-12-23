# encoding: utf-8
require 'spec_helper'

describe RfqxEmc::Category do
  it "name shouldn't be nil" do
    cate = FactoryGirl.build(:category, :name => nil)
    cate.should_not be_valid
  end
  
  it "should reject duplidate name for active ones" do
    cate1 = FactoryGirl.create(:category, :name => 'test')
    cate2 = FactoryGirl.build(:category, :name => 'TEst')
    
    cate2.should_not be_valid
  end
  
  it "should OK for duplidate name for non active ones" do
    cate1 = FactoryGirl.create(:category, :name => 'test', :active => false)
    cate2 = FactoryGirl.build(:category, :name => 'TEst', :active => false)
    
    cate2.should be_valid
  end  
end