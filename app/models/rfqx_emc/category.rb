module RfqxEmc
  class Category < ActiveRecord::Base
    #attr_accessible :active, :description, :last_updated_by_id, :name
    belongs_to :rfq
    belongs_to :last_updated_by, :class_name => 'Authentify::User'
  
    attr_accessible :name, :description, :active, :last_updated_by_id, :as => :role_new
    attr_accessible :name, :description, :active, :as => :role_update

    validates :name, :presence => true, :uniqueness => { :scope => :active, :case_sensitive => false }, :if => "active"
  
    scope :active_cate, where(:active => true) 
    scope :inactive_cate, where(:active => false)
  end
end
