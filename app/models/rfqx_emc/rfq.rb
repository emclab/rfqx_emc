# encoding: utf-8

module RfqxEmc
  class Rfq < ActiveRecord::Base
    attr_accessible :active, :category_id, :customer_id, :emc_eng_id, :finish_date, :last_updated_by_id, :need_report, :product_id, :report_language, :rfq_date, :safety_eng_id, :sales_id, :start_date, :top_secret
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
    belongs_to :customer, :class_name => 'Customerx::Customer'
    belongs_to :category
    belongs_to :sales, :class_name => 'Authentify::User'
    belongs_to :emc_eng, :class_name => 'Authentify::User'
    belongs_to :safety_eng, :class_name => 'Authentify::User'
    belongs_to :product, :class_name => 'ProductxEmcIt::Product'
    #has_one :product, :class_name => 'ProductxEmcIt::Product'
    has_many :rfq_test_items
    has_many :test_items, :through => :rfq_test_items
    has_many :rfq_standards
    has_many :standards, :through => :rfq_standards
    has_many :quotes, :class_name => 'Quotex::Quote'

    accepts_nested_attributes_for :rfq_standards, :reject_if => proc {|std| std['standard_id'].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :rfq_test_items, :reject_if => proc {|item| item['test_item_id'].blank? }, :allow_destroy => true
    accepts_nested_attributes_for :product, :reject_if => proc {|prod| prod['name'].blank? && prod['model'].blank? }

    before_save :check_need_report

    attr_accessible :customer_id, :category_id, :cust_contact_name, :cust_contact_phone,
                  :need_report, :report_language, :start_date, :finish_date, :sales_id, :rfq_date, :customer_name_autocomplete,
                  :rfq_standards_attributes, :rfq_test_items_attributes, :emc_eng_id, :safety_eng_id, :note, :product_attributes,
                  :manufacturer_id,
                  :as => :role_new
    attr_accessible :active, :category_id, :cust_contact_name, :cust_contact_phone, :note,
                  :need_report, :report_language, :start_date, :finish_date, :sales_id, :emc_eng_id, :safety_eng_id, :rfq_date,
                  :rfq_standards_attributes, :rfq_test_items_attributes, :product_attributes,
                  :manufacturer_id,
                  :as => :role_update
    attr_accessor   :keyword, :earliest_created_at, :latest_created_at, :eng_id_s, :standard_id_s, :test_item_id_s,
                  :category_id_s, :sales_id_s, :customer_id_s
    attr_accessible :keyword, :eng_id_s, :sales_id_s, :standard_id_s, :category_id_s, :test_item_id_s,
                  :earliest_created_at, :latest_created_at, :customer_id_s, :manufacturer_id,
                  :as => :role_search

    validates :rfq_date, :presence => true
    validates :cust_contact_name, :presence => true
    validates :customer_id, :presence => true
    validates :category_id, :presence => true
    validates :sales_id, :presence => true
    validates_numericality_of :category_id, :greater_than => 0
    validates_numericality_of :customer_id, :greater_than => 0
    validates_numericality_of :sales_id, :greater_than => 0
    validates_inclusion_of :need_report, :in => [true, false]
    validates_presence_of :report_language, :if => "need_report", :message => '选择报告语言！'

    scope :active_rfq, where(:active => true)
    scope :inactive_rfq, where(:active => false)
    def find_rfqs
      rfqs = RfqxEmc::Rfq.order(:created_at)
      rfqs = rfqs.joins(:product).where("productx_emc_it_products.name like ?", "%#{keyword}%") if keyword.present?
      rfqs = rfqs.where("created_at >= ?", earliest_created_at) if earliest_created_at.present?
      rfqs = rfqs.where("created_at <= ?", latest_created_at) if latest_created_at.present?
      rfqs = rfqs.where("sales_id = ?", sales_id_s) if sales_id_s.present?
      rfqs = rfqs.where("emc_eng_id = ? OR safety_eng_id = ?", eng_id_s, eng_id_s) if eng_id_s.present?
      rfqs = rfqs.where("customer_id = ?", customer_id_s) if customer_id_s.present?
      rfqs = rfqs.where("category_id = ?", category_id_s) if category_id_s.present?
      rfqs = rfqs.where("test_item_id = ?", test_item_id_s) if test_item_id_s.present?
      rfqs = rfqs.joins(:rfq_standards).where("rfq_standards.standard_id = ?", standard_id_s) if standard_id_s.present?

      rfqs
    end

    def customer_name_autocomplete
      self.customer.try(:name)
    end

    def customer_name_autocomplete=(name)
      self.customer = Customer.find_by_name(name) if name.present?
    end

    protected

    def check_need_report
      need_report = false if need_report.nil?
      true
    end 
  end
end
