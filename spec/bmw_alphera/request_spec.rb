require 'spec_helper'
require 'yaml'

describe BmwAlphera::Request do

  before(:all) do 
    config = YAML.load_file('dev_config.yml')
    @access_hash = 
      {
        :dealer_id => config["dealer_id"],
        :dealer_password => config["dealer_password"],
        :user_id => config["user_id"]
      }
    @quote_hash = 
      {
        :application_id => '1237654',
        :brand => 'PBALP',
        :status => "ASUSE",
        :vehicle_source=> "VSEXT", #VEHICLE_SOURCE 
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
        :customer_type => "TCIND", #CUSTOMER_TYPES
        :customer_relation => "RTCST", #CUSTOMER_TYPES
        :title => "TIMRR", #TITLE_CODES
        :gender => "GRMAL", #GENDER
        :date_of_birth => "1984-05-07T00:00:00.0000000+10:00", #to_datetime
        :first_name => "Peter",
        :middle_name => "",
        :last_name => "Long",
        :marital_status => "MSMAR", #MARITAL_STATUS
        :number_of_dependents => 5,
        :australian_resident => "OPTYS", #AUSTRALIAN_RESIDENT
        :drivers_licence_no => "8521452145",
        :drivers_licence_state => "DSVIC" , #STATE_CODES
        :mobile_number => "0393677752",
        :email => "peter.long@bmwfinance.com.au",
        :current_address => {
            :street => "783 Springvale Rd", #unformatted street address
            :suburb => "MULGRAVE",
            :state => "DSVIC", #STATE_CODES
            :post_code => "3170",
            :duration_years => 6, #in years
            :duration_months => 2, #in months
        },
        :current_employer => {
            :name => "MickySoft inc",
            :contact => "James Small",
            :duration_years => 6,
            :duration_months => 2,
        },
        :net_income => 6000,
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
          expect(@request.xml).to include('<VEHICLESOURCE>VSEXT</VEHICLESOURCE>')
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

      describe "customerdetails" do
        it "saves co_applicant" do
          expect(@request.xml).to include('<CO-APPLICANT>OPTNO</CO-APPLICANT>')
        end
        it "saves total_monthly_income" do
          expect(@request.xml).to include('<TOTAL_MONTHLY_INCOME_AMOUNT>6000</TOTAL_MONTHLY_INCOME_AMOUNT>')
        end

      end

      describe "customer_details" do
        
        it "saves prospect_type" do
          expect(@request.xml).to include('<PROSPECT_TYPE>TCIND</PROSPECT_TYPE>')
        end
        it "saves title" do
          expect(@request.xml).to include('<TITLE>TIMRR</TITLE>')
        end
        it "saves gender" do
          expect(@request.xml).to include('<GENDER>GRMAL</GENDER>')
        end
        it "saves date_of_birth" do
          expect(@request.xml).to include('<D_O_BBIRTH>1984-05-07T00:00:00.0000000+10:00</D_O_BBIRTH>')
        end
        it "saves first_name" do
          expect(@request.xml).to include('<FIRST_NAME>Peter</FIRST_NAME>')
        end
        it "saves last_name" do
          expect(@request.xml).to include('<LAST_NAME>Long</LAST_NAME>')
        end
        it "saves maritial_status" do
          expect(@request.xml).to include('<MARITIAL_STATUS>MSMAR</MARITIAL_STATUS>')
        end
        it "saves australian_resident" do
          expect(@request.xml).to include('<AUSTRALIAN_RESIDENT>OPTYS</AUSTRALIAN_RESIDENT>')
        end
        it "saves drivers_licence_no" do
          expect(@request.xml).to include('<LICENSE_NO>8521452145</LICENSE_NO>')
        end
        it "saves drivers_licence_state" do
          expect(@request.xml).to include('<LICENSE_STATE>DSVIC</LICENSE_STATE>')
        end
        it "saves mobile_number" do
          expect(@request.xml).to include('<MOBILENUMBER>0422125254</MOBILENUMBER>')
        end
        it "saves email" do
          expect(@request.xml).to include('<EMAIL_ID>peter.long@bmwfinance.com.au</EMAIL_ID>')
        end
       



      end
    end
    describe '.soap' do 
      it "after initialize saves entire soap envelope" do
        # p @request.soap
        expect(@request.soap).to_not eq(nil)
      end
    end

    describe '.schema' do
      it "resturns schema based on xsd" do
        expect(@request.schema).to_not eq(nil)
      end
    end

    describe '.validate_xml' do
      it "returns [] if not validation errors" do
        expect(@request.validate_xml).to eq([])
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