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
        it "saves brand" do
          expect(@request.xml).to include('<BRANDCODE>PBALP</BRANDCODE>')
        end
        it "saves status" do
          expect(@request.xml).to include('<STATUSCODE>ASUSE</STATUSCODE>')
        end
        it "saves vehicle_source" do
          expect(@request.xml).to include('<VEHICLESOURCE>VSINT</VEHICLESOURCE>')
        end
        it "saves disbursements" do
          expect(@request.xml).to include('<FEESANDCHARGESAMOUNT>500</FEESANDCHARGESAMOUNT>')
        end
        it "saves source_name" do
          expect(@request.xml).to include('<SOURCENAME>BMW GROUP FINANCIAL SERVICES</SOURCENAME>')
        end
        it "saves gst" do
          expect(@request.xml).to include('<GSTINCLUDED>GSTIN</GSTINCLUDED>')
        end
        it "saves asset_price" do
          expect(@request.xml).to include('<ASSETPRICE>59700</ASSETPRICE>')
        end
        it "saves interest_rate" do
          expect(@request.xml).to include('<INTERESTRATE>9.95</INTERESTRATE>')
        end
        it "saves loan_term" do
          expect(@request.xml).to include('<LOANTERM>48</LOANTERM>')
        end
        it "saves residual_percent" do
          expect(@request.xml).to include('<RVPERCENT>12</RVPERCENT>')
        end
        it "saves residual_amount" do
          expect(@request.xml).to include('<RVAMOUNT>0</RVAMOUNT>')
        end
        it "saves state" do
          expect(@request.xml).to include('<STATECODE>DSVIC</STATECODE>')
        end
        it "saves trade_in_amount" do
          expect(@request.xml).to include('<TRADEINAMOUNT>5000</TRADEINAMOUNT>')
        end
        it "saves lct_applicable" do
          expect(@request.xml).to include('<LCTAPPLICABLECODE>LCTST</LCTAPPLICABLECODE>')
        end
        it "saves frequency_type" do
          expect(@request.xml).to include('<FREQUENCYTYPECODE>PFMON</FREQUENCYTYPECODE>')
        end
        it "saves payment_in" do
          expect(@request.xml).to include('<PAYMENTINCODE>PTADV</PAYMENTINCODE>')
        end
        it "saves payment_in_code" do
          expect(@request.xml).to include('<PAYMENTINCODE>PTADV</PAYMENTINCODE>')
        end
        it "saves payment_structure" do
          expect(@request.xml).to include('<PAYMENTSTRUCTURETYPE>PSNRM</PAYMENTSTRUCTURETYPE>')
        end
        it "saves total_deposit" do
          expect(@request.xml).to include('<TOTALDEPOSIT>5000</TOTALDEPOSIT>')
        end
        it "saves customer_name" do
          expect(@request.xml).to include('<CUSTOMERNAME>Peter Long</CUSTOMERNAME>')
        end
        it "saves mobile_number" do
          expect(@request.xml).to include('<MOBILENUMBER>0422125254</MOBILENUMBER>')
        end
        it "saves application_type" do
          expect(@request.xml).to include('<APPLICATIONTYPE>APFIN</APPLICATIONTYPE>')
        end
        it "saves customer_name" do
          expect(@request.xml).to include('<CUSTOMERNAME>Peter Long</CUSTOMERNAME>')
        end
        it "saves email" do
          expect(@request.xml).to include('<EMAILADDRESS>peter.long@bmwfinance.com.au</EMAILADDRESS>')
        end
        it "saves customer_type" do
          expect(@request.xml).to include('<CUSTOMERTYPE>TCIND</CUSTOMERTYPE>')
        end
        it "saves sub_product_id" do
          expect(@request.xml).to include('<SUBPRODUCTID>39</SUBPRODUCTID>')
        end
        it "saves product_id" do
          expect(@request.xml).to include('<PRODUCTID>8</PRODUCTID>')
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