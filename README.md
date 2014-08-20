# BmwAlphera

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'bmw_alphera'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bmw_alphera

## Usage

    access_hash = {
      :application_id => "uniqe appliction_id",
      :dealer_id => "dealer_id",
      :dealer_password => "dealer_password",
      :user_id => "user_password"
    } 

    quote_hash = {
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
      :sub_product_id => 39, #PRODUCT_SUBPRODUCT_MAPPING[1]
      :product_id => 8 #PRODUCT_SUBPRODUCT_MAPPING[1]
    }

    entity_hash = {

    } 

    request = BmwAlphera::Request.new(access: access_hash, quote: quote_hash, entity: entity_hash)    

Codes for quotes and entity hashes:

    APPLICATION_STATUS = [
      { :value => "APADG", :description => "Awaiting Director/GM Approval" },
      { :value => "APAPD", :description => "Approved" },
      { :value => "APAPR", :description => "Acceptance Processing" },
      { :value => "APARF", :description => "Awaiting Reference" },
      { :value => "APAWD", :description => "Awaiting Dealer Action" },
      { :value => "APCLD", :description => "Application Cancelled" },
      { :value => "APCND", :description => "Conditionally approved" },
      { :value => "APFIN", :description => "Financed" },
      { :value => "APFSL", :description => "Final Settlement" },
      { :value => "APHLD", :description => "Held Offer" },
      { :value => "APNPW", :description => "Not Proceeded With" },
      { :value => "APPPA", :description => "Pending Payment Approval" },
      { :value => "APRCL", :description => "Recalled" },
      { :value => "APREJ", :description => "Rejected" },
      { :value => "APSAV", :description => "Saved" },
      { :value => "APSBT", :description => "Submitted" },
      { :value => "APSES", :description => "Saved with Customer Mail Sent" },
      { :value => "APSLD", :description => "Settlements Loading" },
      { :value => "APSRR", :description => "Saved with Customer Response Received" },
      { :value => "APSTP", :description => "Settlement Processing"}
    ]

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

## Contributing

1. Fork it ( https://github.com/[my-github-username]/bmw_alphera/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
