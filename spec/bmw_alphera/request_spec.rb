require 'spec_helper'
require 'yaml'

describe BmwAlphera::Request do

  before(:all) do 
    config = YAML.load_file('dev_config.yml')
    @access_hash = 
      {
        :application_id => config["appliction_id"],
        :dealer_id => config["dealer_id"],
        :dealer_password => config["dealer_password"],
        :user_id => config["user_password"]
      }
    @quote_hash = 
      {
        :brand_code => 'PBALP',
        :status_code => "ASUSE",
        :vehicle_source=> "VSINT", #VEHICLE_SOURCE 
        :disbursements => 500,
        :source_name => 'BMW GROUP FINANCIAL SERVICES', #Company Name
        :gst => 'GSTIN', #GST CODES
        :asset_price =>59700, #Glassguide vehicle + options price
        :interest_rate => 9.9500,
        :discount => 0.0,
        :dealer_delivery => 0.0,
        :loan_term => 48, #term/12*2
        :rv_percent => 12,
        :rv_amount => 0,
        :regisrtation => 0.0,
        :ctp_insurance => 0.0,
        :state_code => 'DSVIC', #STATE_CODES
        :trade_in_price => 5000,
        :lct_applicable_code => "LCTST", #LCT_APPLICABLE_CODES
        :frequency_type_code => "PFMON", #FREQUENCY_APPLICABLE
        :deposit_amount => 0,
        :payment_in_code => "PTADV", #PAYMENT_IN_CODES
        :payment_structure => "PSNRM", #PAYMENT_STRUCTURE
        :otther_asset_flag => 1,
        :total_deposit => 5000,
        :make => nil,
        :series => nil,
        :model => nil,
        :full_name => "Peter Long",
        :mobile_number => "0422125254",
        :application_type => "APFIN", #APPLICATION_TYPES
        :email => 'peter.long@bmwfinance.com.au',
        :customer_type => 'TCIND', #CUSTOMER_TYPES
        :TAXAPPLYDATE => DateTime.now,
        :RVEFFECTIVEDATE => DateTime.now,
        :SUBPRODUCTID => 39, #PRODUCT_SUBPRODUCT_MAPPING[1]
        :PRODUCTID => 8 #PRODUCT_SUBPRODUCT_MAPPING[1]
      }

    @entity_hash = 
      {

      }  
    @request = BmwAlphera::Request.new(access: @access_hash, quote: @quote_hash, entity: @entity_hash)
  end

  it { should have_one(:response).dependent(:destroy) }
  it { should respond_to(:access) }
  it { should respond_to(:quote) }
  it { should respond_to(:entity) }
  it { should respond_to(:soap) }
  it { should validate_presence_of(:access) }
  it { should validate_presence_of(:quote) }
  it { should validate_presence_of(:entity) }

  describe '.to_soap' do
    describe '.xml' do    
      it "after initialize saves xml message" do
        # p @request.xml
        expect(@request.xml).to_not eq(nil)
      end
      describe "quote details" do
        it "saves brand_code" do
          expect(@request.xml).to include('<BRANDCODE>PBALP</BRANDCODE>')
        end
      end
    end
    describe '.soap' do 
      it "after initialize saves entire soap envelope" do
        # p @request.soap
        expect(@request.soap).to_not eq(nil)
      end
    end

  
  end

  # describe '.post' do
  #   it "post the data" do
  #     request = BmwAlphera::Request.new
  #     # xml = request.to_soap(@access_hash)
  #     xml = File.read('test_request.xml')
  #     post = request.post(xml)
  #     p post
  #     expect(post.code).to eq(200)
  #   end
  # end 
end