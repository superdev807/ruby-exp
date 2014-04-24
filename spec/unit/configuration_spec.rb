require 'spec_helper'

describe RailsExceptionHandler::Configuration do
  describe ".initialize" do
    before(:each) do
      @configuration = RailsExceptionHandler::Configuration.new
    end

    it "should add :production to environments" do
      @configuration.environments.should == [:production]
    end

    it "should set storage_strategies to []" do
      @configuration.storage_strategies.should == []
    end

    it "should set store_user_info to false" do
      @configuration.store_user_info = false
    end

    it "should set filters to [] " do
      @configuration.filters.should == []
    end

    it "should initialize responses to an empty hash" do
      @configuration.responses.should == {}
    end

    it "should set the reponse_mapping to {}" do
      @configuration.response_mapping.should == {}
    end

    it "should set the fallback layout to 'application'" do
      @configuration.fallback_layout.should == 'application'
    end

    it "should set the mongoid_store_in to nil" do
      @configuration.mongoid_store_in.should be_nil
    end

    it "should set the default active record configuration" do
      @configuration.active_record_store_in.should eq({
        database: 'exception_database',
        record_table: 'error_messages'
      })
    end
  end

end
