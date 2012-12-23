# encoding: utf-8
require_dependency "rfqx_emc/application_controller"

module RfqxEmc
  class CategoriesController < ApplicationController
    include Authentify::SessionsHelper
    include Authentify::AuthentifyUtility
    include Authentify::UserPrivilegeHelper
    
    before_filter :require_signin
    #before_filter :require_employee
    helper_method :has_edit_create_right?

    def index
      if has_edit_create_right?
        @categories = RfqxEmc::Category.order('name')
      else
        @categories = RfqxEmc::Category.active_cate.order('name')
      end
      @title = "客户分类"
    end

    def new
      @category = RfqxEmc::Category.new
      @title = "输入客户分类"
    end

    def create
      if has_edit_create_right?
        #dynamic attr_accessible
        @category = RfqxEmc::Category.new(params[:category], :as => :role_new)
        @category.last_updated_by_id = session[:user_id]

        if @category.save
          #@categories = Category.all
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Category saved successfully")

        # send out email
        #NotifyMailer.new_prod_email(@product).deliver
        else
          render :action => "new"
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=NO right to create category!")
      end
    end

    def edit
      if !has_edit_create_right?
        redirect_to URI.escape(SUBURI + "/view_handler?index=0?msg=权限不足！")
      end
      @category = RfqxEmc::Category.find(params[:id])
      @title = "更新客户分类"
    end

    def update
      @category = RfqxEmc::Category.find(params[:id])
      #@category.reload. caused nil.reload error

      if has_edit_create_right?
        @category.last_updated_by_id = session[:user_id]
        if @category.update_attributes!(params[:category], :as => :role_update)
          redirect_to URI.escape(SUBURI + "/view_handler?index=0&msg=Category was successfully updated")
        else
          flash.now[:error] = "Item was not updated"
          render 'edit'
        end
      else
        redirect_to URI.escape(SUBURI + "/view_handler?index=0?msg=权限不足！")
      end
    end

    def show
      @category = RfqxEmc::Category.find(params[:id])
      @title = "客户分类内容"
    end

    protected

    def has_edit_create_right?
      #return trues
      grant_access?('create', 'rfqx_emc_categories', nil, nil) || grant_access?('update', 'rfqx_emc_categories', nil, nil)
      #return true if sales_dept_head? || eng_dept_head? || corp_head? || ceo?
    end

  end
end
