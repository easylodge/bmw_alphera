## *NOTE: The BMW Alphera integration was removed from EasyLodge on 6 October 2020. #8681*

---


# BmwAlphera

Submit finance applications to BMW Alphera.

## Installation

Add this line to your application's Gemfile:

    gem 'bmw_alphera'

And then execute:

    $ bundle

Then run install generator:
  
  rails g bmw_alphera:install

Then run migrations:

  rake db:migrate

## Usage

### Request

    access_hash = {
      :dealer_id => "dealer_id",
      :dealer_password => "dealer_password",
      :user_id => "user_password"
    } 

    quote_hash = {
      :application_id => "uniqe appliction_id",
      :brand => 'PBALP', # See BRAND_CODES
      :status => "ASUSE", # See STATUS_CODES
      :vehicle_source=> "VSINT", # See VEHICLE_SOURCE 
      :disbursements => 500, # Fees and Charges Amount
      :source_name => 'BMW GROUP FINANCIAL SERVICES', #Company Name
      :gst => 'GSTIN', # See GST_CODES
      :asset_price =>59700, # Glassguide vehicle + options price
      :interest_rate => 9.95,
      :dealer_delivery => 0.0,
      :loan_term => 48, 
      :residual_percent => 12,
      :residual_amount => 0,
      :state => 'DSVIC', # See STATE_CODES
      :trade_in_amount => 5000,
      :lct_applicable => "LCTST", # See LCT_APPLICABLE_CODES
      :frequency_type => "PFMON", # See FREQUENCY_APPLICABLE
      :deposit_amount => 0,
      :payment_in => "PTADV", # See PAYMENT_IN_CODES
      :payment_structure => "PSNRM", # See PAYMENT_STRUCTURE
      :other_asset_flag => 1,
      :total_deposit => 5000,
      :make => nil,
      :series => nil,
      :model => nil,
      :customer_name => "Peter Long",
      :mobile_number => "0422125254",
      :application_type => "APFIN", # See APPLICATION_TYPES
      :email => 'peter.long@bmwfinance.com.au',
      :customer_type => 'TCIND', # See CUSTOMER_TYPES
      :sub_product_id => 39, # See PRODUCT_SUBPRODUCT_MAPPING
      :product_id => 8 # See PRODUCT_SUBPRODUCT_MAPPING
    }

    consumer_entity_hash = {
      :customer_type => "TCIND", # See CUSTOMER_TYPES
      :customer_relation => "RTCST", # See PROSPECT_TYPES
      :title => "TIMRR", # See TITLE_CODES
      :gender => "GRMAL", # See GENDER
      :date_of_birth => "1984-05-07T00:00:00.0000000+10:00", # Must use .to_datetime
      :first_name => "Peter",
      :middle_name => "John",
      :last_name => "Long",
      :marital_status => "MSMAR", # See MARITAL_STATUS
      :number_of_dependents => 5,
      :australian_resident => "OPTYS", # See AUSTRALIAN_RESIDENT
      :drivers_licence_no => "8521452145",
      :drivers_licence_state => "DSVIC" , # See STATE_CODES
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

    commercial_entity_hash = {
      :customer_type => "TCCOR", #CUSTOMER_TYPES
      :relation => "RTCST", #PROSPECT_RELATIONS
      :company_name => "Urban Vertical Pty Ltd",
      :year_est => 1999,
      :ref_contact_number => '0215553300',
      :abn => '71163072508',
      :net_income => 6000
    } 

    request = BmwAlphera::Request.new(access: access_hash, quote: quote_hash, entity: entity_hash)

#### Instance Methods:

    request.access - Access Hash
    request.quote - Quote Hash
    request.entity - Entity Hash
    request.xml - XML message of request
    request.validate_xml - Validate xml, returns [] if no errors
    request.soap - Complete SOAP envelope
    request.post - Post to BMW Alphera

### Response

    post = request.post
    response = BmwAlphera::Response.create(xml: post.body, 
      headers: post.headers, code: post.code, 
      success: post.success?, request_id: request.id)

#### Instance Methods:

    response.as_hash - Hash of whole response
    response.xml - XML of response
    response.code - Response status code
    response.headers - Response headers
    response.success? - Returns true or false (based on Httparty response)
    response.error - Response errors if any
    response.result - The useful part of the response in hash format


Codes for quotes and entity hashes:

    BRAND_CODES = [
      { :code => "PBBMW", :description => "BMW" },
      { :code => "PBMIN", :description => "Mini" },
      { :code => "PBABT", :description => "Alphabet" },
      { :code => "PBALP", :description => "Alphera" },
      { :code => "PBU2D", :description => "Up2Drive" },
      { :code => "MTOFS", :description => "BMW Motorrad" }
    ]

    STATUS_CODES = [
      { :code => "ASNEW", :description => "New" },
      { :code => "ASUSE", :description => "Used" },
      { :code => "ASDEM", :description => "Demo" }
    ]

    VEHICLE_SOURCE = [
      { :code => "VSINT", :description => "Dealer" },
      { :code => "VSEXT", :description => "Private" }
    ]

    GST_CODES = [
      { :code => "GSTIN", :description => "Inclusive" },
      { :code => "GSTEX", :description => "Exclusive" },
      { :code => "GSTNA", :description => "N/A" }
    ]

    STATE_CODES = [
      {:code => "DSACT", :description => "ACT" },
      {:code => "DSNSW", :description => "NSW" },
      {:code => "DSNTT", :description => "NT" },
      {:code => "DSQLD", :description => "QLD" },
      {:code => "DSSAU", :description => "SA" },
      {:code => "DSTAS", :description => "TAS" },
      {:code => "DSVIC", :description => "VIC" },
      {:code => "DSXWA", :description => "WA" }
    ]
 
    LCT_APPLICABLE_CODES = [
      { :code => "LCTGR", :description => "Green" },
      { :code => "LCTNA", :description => "NA" },
      { :code => "LCTST", :description => "Standard" }
    ]

    FREQUENCY_APPLICABLE = [
      { :code => "PFANU", :description => "Annually" },
      { :code => "PFHLY", :description => "Half Yearly" },
      { :code => "PFMON", :description => "Monthly" },
      { :code => "PFQUA", :description => "Quarterly" }
    ]

    PAYMENT_IN_CODES = [
      { :code => "PTADV", :description => "Advance" },
      { :code => "PTARR", :description => "Arrears" }
    ]

    PAYMENT_STRUCTURE = [
      { :code => "PSNRM", :description => "Normal" },
      { :code => "PSSTR", :description => "Structure" }
    ]

    APPLICATION_TYPES = [
      { :code => "APCAS", :description => "Cash" },
      { :code => "APFIN", :description => "Finance" }
    ]

    
    CUSTOMER_TYPES = [
      { :code => "TCIND", :description => "Consumer" },
      { :code => "TCCOR", :description => "Commercial"}
    ]

    GENDER = [
      { :code => "GRMAL", :description => "Male" },
      { :code => "GRFML", :description => "Female" }
    ]

    MARITAL_STATUS = [
      { :code => "MSDEF", :description => "Defacto" },
      { :code => "MSDIV", :description => "Divorced" },
      { :code => "MSMAR", :description => "Married" },
      { :code => "MSSIN", :description => "Single" },
      { :code => "MSWID", :description => "Widowed" },
      { :code => "MSSEP", :description => "Separated" }
    ]

    AUSTRALIAN_RESIDENT = [
      { :code => "OPTYS", :description => "Yes" },
      { :code => "OPTNO", :description => "No" }
    ]

    EMPLOYMENT_STATUS = [
      { :code => "ESRTD", :description => "Retired" },
      { :code => "ESSLF", :description => "Self employed" },
      { :code => "ESPRT", :description => "Part Time" },
      { :code => "ESFRT", :description => "Full Time" },
      { :code => "ESCSL", :description => "Casual" }
    ]

    TITLE_CODES = [
      { :code => "TIMRR", :description => "Mr" },
      { :code => "TRMRS", :description => "Mrs" },
      { :code => "TRMSS", :description => "Ms" },
      { :code => "TIMIS", :description => "Miss" },
      { :code => "TIDRR", :description => "Dr" },
      { :code => "TIPRF", :description => "Prof" },
      { :code => "TRSIR", :description => "Sir" },
      { :code => "TILDY", :description => "Lady" },
      { :code => "TRHON", :description => "Hon" },
      { :code => "TIREV", :description => "Rev" }
    ]

    PROSPECT_RELATIONS = [
      { :code => "RTCST", :description => "Customer" },
      { :code => "RTCOA", :description => "Co-Applicant:" },
      { :code => "RTGA1", :description => "Guarantor 1" },
      { :code => "RTGA2", :description => "Guarantor 2" }
    ]

    PRODUCT_SUBPRODUCT_MAPPING = [
      { :product_id => 10, :product_name => "Chattel Mortgage", :sub_product_id => 15, :sub_product_name => "Chattel Mortgage", :fees_charges => [
                                                             { :description => "Stamp Duty ( Only for NSW )", :code => "FCSTP"}, 
                                                             { :description => "PPSR Fee", :code => "FCVSR" },
                                                             { :description => "Establishment Fee", :code => "FCESF"},
                                                             { :description => "Dealer Origination Fees", :code => "FCDOF"}
                                                            ]}, 
      { :product_id => 7, :product_name => "Consumer Loan", :sub_product_id => 11, :sub_product_name => "Loan", :fees_charges => [
                                                             { :description => "Stamp Duty ( Only for NSW )", :code => "FCSTP" }, 
                                                             { :description => "PPSR Fee", :code => "FCVSR" },
                                                             { :description => "Establishment Fee", :code => "FCESF" },
                                                             { :description => "Dealer Origination Fees", :code => "FCDOF" }
                                                            ]}, 
      { :product_id => 11, :product_name => "Financial Lease", :sub_product_id => 47, :sub_product_name => "Novated Lease", :fees_charges => [
                                                             { :description => "Establishment Fee", :code => "FCESF" },
                                                             { :description => "Dealer Origination Fees", :code => "FCDOF" }
                                                            ]}, 
      { :product_id => 8, :product_name => "Hire Purchase", :sub_product_id => 9, :sub_product_name => "Hire Purchase", :fees_charges => [
                                                             { :description => "Establishment Fee", :code => "FCESF" },
                                                             { :description => "Dealer Origination Fees", :code => "FCDOF" }
                                                            ]}, 
  ]

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bmw_alphera/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. See 'dev.rb' in root for instructions
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request
