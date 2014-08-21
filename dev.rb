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
@quote_hash = 
  {
    :application_id => 321456,
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
    :co_applicatant => "OPTYS",

    :customer_type => "TCIND", #CUSTOMER_TYPES
    :customer_relation => "RTCST", #CUSTOMER_TYPES
    :title => "TIMRR", #TITLE_CODES
    :gender => "GRMAL", #GENDER
    :date_of_birth => "1984-05-07", #to_datetime
    :first_name => "Peter",
    :middle_name => "",
    :last_name => "Long",
    :marital_status => "MSMAR", #MARITAL_STATUS
    :no_of_dependents => 5,
    :australian_resident => "OPTYS", #AUSTRALIAN_RESIDENT
    :drivers_licence_no => "8521452145",
    :drivers_licence_state => "DSVIC" , #STATE_CODES
    :mobile_number => "0393677752",
    :email => "peter.long@bmwfinance.com.au",
    :street_address => "783 Springvale Rd", #unformatted street address
    :suburb => "MULGRAVE",
    :state => "DSVIC", #STATE_CODES
    :post_code => "3170",
    :address_duration_years => 6, #in years
    :address_duration_months => 2, #in months
    :employer => (entity[:employers_name] rescue ""),
    :employer_contact => (entity[:employer_contact] rescue ""),
    :employment_duration_years => (entity[:employment_duration_years] rescue ""),
    :employment_duration_months => (entity[:employment_duration_years] rescue "" ),
    :net_income => 6000,
    :landlord => (entity_hash[:landlord] rescue ""),
    :landlord_phone => (entity_hash[:landlord_phone] rescue ""),

  }  
@req = BmwAlphera::Request.new(access: @access_hash, quote: @quote_hash, entity: @entity_hash)

# @post = @req.post
# @res = VedaIdmatrix::Response.create(xml: @post.body, headers: @post.header, code: @post.code, success: @post.success?, request_id: @req.id)

# puts "This is the result of VedaIdmatrix::Request.access: #{VedaIdmatrix::Request.access}"
puts "You have a @req and @res object to use"


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

  