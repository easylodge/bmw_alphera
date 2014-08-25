# Note for gem developer/contributer
# Create file called 'dev_config.yml' in your project root with the following:
#
# url: 'https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4'
# access_code: 'your access code'
# password: 'your password'
#
# run 'bundle console'and then
# load 'dev.rb' to load this seed data

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => ':memory:',
  )
require_relative 'spec/schema'


@config = YAML.load_file('dev_config.yml')
@access_hash = 
  {
    :dealer_id => @config["dealer_id"],
    :dealer_password => @config["dealer_password"],
    :user_id => @config["user_id"]
  }
@consumer_quote_hash = 
  {
    :application_id => 321666,
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
    :payment_in => "PTARR", #PAYMENT_IN_CODES
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
    :sub_product_id => 11, #PRODUCT_SUBPRODUCT_MAPPING
    :product_id => 7 #PRODUCT_SUBPRODUCT_MAPPING
  }

@commercial_quote_hash = 
  {
    :application_id => 321999,
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
    :payment_in => "PTARR", #PAYMENT_IN_CODES
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
    :customer_type => 'TCCOR', #CUSTOMER_TYPES
    :sub_product_id => 11, #PRODUCT_SUBPRODUCT_MAPPING
    :product_id => 7 #PRODUCT_SUBPRODUCT_MAPPING
  }  

@consumer_entity_hash = 
  {
    :customer_type => "TCIND", #CUSTOMER_TYPES
    :customer_relation => "RTCST", #CUSTOMER_TYPES
    :title => "TIMRR", #TITLE_CODES
    :gender => "GRMAL", #GENDER
    :date_of_birth => "1984-05-07T00:00:00.0000000+10:00", #to_datetime
    :first_name => "Peter",
    :middle_name => "John",
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
    :previous_address => {
        :street => "18 Spring Rd", #unformatted street address
        :suburb => "TABLEVIEW",
        :state => "DSVIC", #STATE_CODES
        :post_code => "3170",
        :duration_years => 2, #in years
        :duration_months => 1, #in months
    },
    :current_employer => {
        :name => "MickySoft inc",
        :contact => "James Small",
        :duration_years => 6,
        :duration_months => 2,
    },
    :previous_employer => {
        :name => "BrotherSoft inc",
        :contact => "James May",
        :duration_years => 2,
        :duration_months => 1,
    },
    :net_income => 6000,
    :landlord => "Mike Phils",
    :landlord_phone => "0116664400",

  }

  @commercial_entity_hash = {
    :customer_type => "TCCOR", #CUSTOMER_TYPES
    :relation => "RTCST", #PROSPECT_RELATIONS
    :company_name => "Urban Vertical Pty Ltd",
    :year_est => 1999,
    :ref_contact_number => '0215553300',
    :abn => '71163072508',
    :net_income => 6000
  }  

@con_req = BmwAlphera::Request.new(access: @access_hash, quote: @consumer_quote_hash, entity: @consumer_entity_hash)
@com_req = BmwAlphera::Request.new(access: @access_hash, quote: @commercial_quote_hash, entity: @commercial_entity_hash)

# @con_post = @con_req.post
# @com_post = @com_req.post

# @con_res = BmwAlphera::Response.create(xml: @con_post.body, headers: @con_post.header, code: @con_post.code, success: @con_post.success?, request_id: @con_req.id)
# @com_res = BmwAlphera::Response.create(xml: @com_post.body, headers: @com_post.header, code: @com_post.code, success: @com_post.success?, request_id: @com_req.id)

# puts "This is the result of VedaIdmatrix::Request.access: #{VedaIdmatrix::Request.access}"
puts "You have a @con_req and @com_req object to use"


# if VedaIdmatrix::Request.access[:access_code].nil?
#   puts "There is no access_code specified in lib/config/veda_idmatrix.yml"
#   puts "Please add your access code and run this file again"
#   exit
# elsif VedaIdmatrix::Request.access[:password].nil?
#   puts "There is no password specified in lib/config/veda_idmatrix.yml"
#   puts "Please add your password and run this file again"
# elsif VedaIdmatrix::Request.access[:url].nil?
#   puts "You have removed the url in lib/config/veda_idmatrix.yml"
#   puts "It should be 'https://ctaau.vedaxml.com/cta/sys2/idmatrix-v4'"
#   exit
# else
#   puts "Your access details are set!"
# end

  