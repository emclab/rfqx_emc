# encoding: utf-8
require 'spec_helper'

module RfqxEmc
  describe RfqxEmc::CategoriesController do
    before(:each) do
    #the following recognizes that there is a before filter without execution of it.
      controller.should_receive(:require_signin)
    #controller.should_receive(:session_timeout)
    end

    render_views

    describe "GET 'index'" do
      it "should be successful" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'eng')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'all_index_view', :table_name => 'test_itemx_test_plans')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        cat = FactoryGirl.create(:category, :last_updated_by_id => u.id)
        get 'index', {:use_route => :rfqx_emc}
        response.should be_success
      end
    end

    describe "GET 'new'" do
      it "should be successful" do
        get 'new', {:use_route => :rfqx_emc}
        response.should be_success
      end
    end

    describe "Post 'create'" do
      describe "success" do
        before(:each) do
          
        end

        it "should create a category" do

          lambda do
            ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales_dept_head')
            action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'rfqx_emc_categories')
            right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
            ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
            u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
            @category = FactoryGirl.attributes_for(:category, :last_updated_by_id => u.id)
            session[:user_id] = u.id
            session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
            post :create, {:use_route => :rfqx_emc, :category => @category}  #,  :session => session
          end.should change(RfqxEmc::Category, :count).by(1)
        end

        it "should redirect to the category index page" do
          lambda do
            ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales_dept_head')
            action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'rfqx_emc_categories')
            right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
            ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
            u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
            @category = FactoryGirl.attributes_for(:category, :last_updated_by_id => u.id)
            session[:user_id] = u.id
            session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
            post :create, {:use_route => :rfqx_emc, :category => @category }
            response.should redirect_to URI.escape("/view_handler?index=0&msg=Category saved successfully")
          end.should change(RfqxEmc::Category, :count).by(1)
        end

      end

      describe "failure" do
        before(:each) do
          ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales_dept_head')
          action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'rfqx_emc_categories')
          right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
          ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
          u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
          session[:user_id] = u.id
          session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
          #@category = FactoryGirl.attributes_for(:category, :last_updated_by_id => u.id)

          @category = FactoryGirl.attributes_for(:category, :name => '')
          #session[:eng] = true
          session[:eng_dept_head] = true
        end

        it "should not create a category" do
          lambda do
            post :create, {:use_route => :rfqx_emc, :category => @category }
          end.should change(RfqxEmc::Category, :count).by(0)
        end

        it "should redirect to new category page" do

          post :create, {:use_route => :rfqx_emc, :category => @category }
          response.should render_template('new')
        end
      end

    end

    describe "'update'" do
      it "should be successful with rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales_dept_head')
        action = FactoryGirl.create(:authentify_sys_action_on_table, :action => 'create', :table_name => 'rfqx_emc_categories')
        right = FactoryGirl.create(:authentify_sys_user_right, :sys_user_group_id => ugrp.id, :sys_action_on_table_id => action.id)
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        category = FactoryGirl.create(:category)
        session[:corp_head] = true
        session[:user_name] = 'tester'
        put 'update', {:use_route => :rfqx_emc, :id => category.id, :category => {:description => "desp changed" }  }
        flash[:notice].should be_nil
        response.should redirect_to URI.escape("/view_handler?index=0&msg=Category was successfully updated")
      end

      it "should be rejected without rights" do
        ugrp = FactoryGirl.create(:authentify_sys_user_group, :user_group_name => 'sales_dept_head')
        ul = FactoryGirl.create(:authentify_user_level, :sys_user_group_id => ugrp.id )
        u = FactoryGirl.create(:authentify_user, :user_levels => [ul])
        session[:user_id] = u.id
        session[:user_privilege] = Authentify::UserPrivilegeHelper::UserPrivilege.new(u.id)
        category = FactoryGirl.create(:category)
        session[:acct_dept_head] = true
        session[:eng] = false
        session[:user_name] = 'tester'
        put 'update', {:use_route => :rfqx_emc, :id => category.id, :category => {:description => "desp changed" }   }
        flash[:notice].should be_nil
        response.should redirect_to URI.escape("/view_handler?index=0?msg=权限不足！")
      end
    end

  end
end
