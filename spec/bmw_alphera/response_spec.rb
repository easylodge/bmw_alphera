require 'spec_helper'
require 'yaml'

describe BmwAlphera::Response do

  before(:all) do 
    config = YAML.load_file('dev_config.yml')
    @access_hash = 
      {
        :application_id => config["appliction_id"],
        :dealer_id => config["dealer_id"],
        :dealer_password => config["dealer_password"],
        :user_id => config["user_id"]
      }

     @quote_hash = 
      {
        :brand => 'PBALP',
        :status => "ASUSE",
        :vehicle_source=> "VSINT", #VEHICLE_SOURCE 
        :disbursements => 500,
        :source_name => 'BMW GROUP FINANCIAL SERVICES', #Company Name
        :gst => 'GSTIN', #GST CODES
        :asset_price =>59700, #Glassguide vehicle + options price
        :interest_rate => 9.95,
        :dealer_delivery => 0.0,
        :loan_term => 48, #term/12*2
        :residual_percent => 12,
        :residual_amount => 0,
        :state => 'DSVIC', #STATE_CODES
        :trade_in_amount => 5000,
        :lct_applicable => "LCTST", #LCT_APPLICABLE_CODES
        :frequency_type => "PFMON", #FREQUENCY_APPLICABLE
        :deposit_amount => 0,
        :payment_in => "PTADV", #PAYMENT_IN_CODES
        :payment_structure => "PSNRM", #PAYMENT_STRUCTURE
        :other_asset_flag => 1,
        :total_deposit => 5000,
        :make => nil,
        :series => nil,
        :model => nil,
        :customer_name => "Peter Long",
        :mobile_number => "0422125254",
        :application_type => "APFIN", #APPLICATION_TYPES
        :email => 'peter.long@bmwfinance.com.au',
        :customer_type => 'TCIND', #CUSTOMER_TYPES
        :sub_product_id => 39, #PRODUCT_SUBPRODUCT_MAPPING[1]
        :product_id => 8 #PRODUCT_SUBPRODUCT_MAPPING[1]
      }

    @entity_hash = 
      {

      }  
    @request = BmwAlphera::Request.new(access: @access_hash, quote: @quote_hash, entity: @entity_hash)
    @post = @request.post
    @response = BmwAlphera::Response.create(xml: @post.body, headers: @post.headers, code: @post.code, success: @post.success?, request_id: @request.id)    
  end

  it { should belong_to(:request).dependent(:destroy) }
  it { should validate_presence_of(:request_id) }
  it { should validate_presence_of(:xml) }
  it { should validate_presence_of(:headers) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:success) }

  describe ".xml" do
    it "returns xml body" do
      expect(@response.xml).to_not eq(nil)
    end
  end

  describe ".error" do
    it "return error" do
      expect(@response.error).to eq(@response.xml)
    end
  end

  describe ".to_hash" do
    it "returns hash" do
      expect(@response.as_hash.class).to eq(Hash)
    end
  end


end