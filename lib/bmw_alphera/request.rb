class BmwAlphera::Request < ActiveRecord::Base
  self.table_name = "bmw_alphera_requests"
  has_one :response, dependent: :destroy, inverse_of: :request
  validates :access, presence: true
  validates :quote, presence: true
  validates :entity, presence: true

  after_initialize :to_soap

  def schema
    fname = File.expand_path( '../../lib/assets/CreateApplication_Input.xsd', File.dirname(__FILE__) )
    File.read(fname)
  end

  def validate_xml
    if self.xml
      xsd = Nokogiri::XML::Schema(self.schema)
      doc = Nokogiri::XML(self.xml)
      xsd.validate(doc).each do |error|
        error.message
      end
    else
      "No xml to validate! - run to_soap"
    end
  end

  def build_application_summary
    application_summary = { 
      :PROVIDER_APPLICATION_ID => quote[:application_id] ,
      :DEALER_ID => access[:dealer_id],
      :DEALER_PASSWORD => access[:dealer_password],
      :ACTION => "SAVE",
      :USER_ID => access[:user_id]
    }
    return application_summary
  end

  def build_quote_details
    if self.quote
      quote_details = {
        :BRANDCODE => quote[:brand], #BRAND_CODES
        :STATUSCODE => quote[:status], #STATUS_CODES
        :VEHICLESOURCE => quote[:vehicle_source], #VEHICLE_SOURCE 
        :FEESANDCHARGESAMOUNT => quote[:disbursements],
        :SOURCENAME => quote[:source_name], #Company Name
        :GSTINCLUDED => quote[:gst], #GST CODES
        :ASSOCIATEDSERVICESAMOUNT => 0.0,
        :ASSETPRICE => quote[:asset_price], #Glassguide vehicle + options price
        :INTERESTRATE => (quote[:interest_rate] rescue 0.0),
        :DISCOUNT => 0.0,
        :DEALERDELIVERY => 0.0,
        :LOANTERM => quote[:loan_term], #term/12*2
        :RVPERCENT => (quote[:residual_percent] rescue 0.0),
        :RVAMOUNT => (quote[:residual_amount] rescue 0.0),
        :REGISTRATION => 0.0,
        :CTPINSURANCE => 0.0,
        :STATECODE => quote[:state], #STATE_CODES
        :TRADEINAMOUNT => (quote[:trade_in_amount] rescue 0.0),
        :LCTAPPLICABLECODE => quote[:lct_applicable], #LCT_APPLICABLE_CODES
        :FREQUENCYTYPECODE => quote[:frequency_type], #FREQUENCY_APPLICABLE
        :CASHDEPOSITAMOUNT => (quote[:deposit_amount] rescue 0.0),
        :PAYMENTINCODE => quote[:payment_in], #PAYMENT_IN_CODES
        :PAYMENTSTRUCTURETYPE => quote[:payment_structure], #PAYMENT_STRUCTURE
        :OTHERASSETFLAG => 1,
        :TOTALDEPOSIT => (quote[:total_deposit] rescue 0.0),
        #:'MAKENAME xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => quote[:make],
        #:'SERIESNAME xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => quote[:series],
        #:'MODELNAME xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => quote[:variant],
        :CUSTOMERNAME => quote[:customer_name],
        :MOBILENUMBER => (quote[:mobile_number] rescue ""),
        :APPLICATIONTYPE => quote[:application_type], #APPLICATION_TYPES
        :EMAILADDRESS => (quote[:email] rescue ""),
        :CUSTOMERTYPE => quote[:customer_type], #CUSTOMER_TYPES
        :TAXAPPLYDATE => DateTime.now,
        :RVEFFECTIVEDATE => DateTime.now,
        :SUBPRODUCTID => quote[:sub_product_id], #PRODUCT_SUBPRODUCT_MAPPING[1]
        :PRODUCTID => quote[:product_id] #PRODUCT_SUBPRODUCT_MAPPING[1]
      }
      quote_details
    else
      "No quote details"
    end
  end

  def build_customer_details

    commercial = false  
    # entity = self.applicants.first unless !self.guarantors.blank?
    # entity = self.guarantors.first if entity.blank?
    # commercial = true if entity.type == "Guarantor"  


    #   epd = entity.entity_personal_details

    #   australian_resident = case epd.citizenship_id
    #   when 1 || 2 || 3 || 4
    #     Constants::AUSTRALIAN_RESIDENT.select{|z| z[:description] == "Yes"}.first[:code]
    #   else
    #     Constants::AUSTRALIAN_RESIDENT.select{|z| z[:description] == "No"}.first[:code]
    #   end
      
    #   eaf = entity.entity_addresses.first

    entity_hash = {}

    if commercial == true
      ## Commercial Code:
      company = self.applicants.first
      customer_details = {
        :PROSPECT_TYPE => entity_hash[:customer_type], #CUSTOMER_TYPES
        :PROSPECT_RELATION => entity_hash[:relation], #PROSPECT_RELATIONS
        :COMPANY_NAME => entity_hash[:company_name],
        :YEAR_EST => entity_hash[:year_est],
        :CORP_PERSONAL_REF_CONT_NO => entity_hash[:ref_contact_number],
        :ABN => entity_hash[:abn]
        #:TITLE => Constants::TITLE_CODES.select{ |z| z[:description].downcase == epd.title.to_s.downcase }.first[:code],
        # :GENDER => Constants::GENDER.select{|z| z[:description] == epd.gender}.first[:code],
        # :D_O_BBIRTH => epd.date_of_birth.to_datetime,
        # :FIRST_NAME => epd.first_name,
        # :'MIDDLE_NAME xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (epd.middle_name rescue ""),
        # :LAST_NAME => epd.last_name,
        # :MARITIAL_STATUS => Constants::MARITAL_STATUS.select{|z| z[:description] == epd.marital_status.description}.first[:code],
        # :'N_O_DEPENDENTS xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => epd.number_of_dependents,
        # :LICENSE_NO => epd.drivers_licence_number,
        # :LICENSE_STATE => Constants::STATE_CODES.select{ |z| z[:title] == epd.drivers_licence_state.abbreviation }.first[:code] ,
        # :MOBILE_NO => (epd.mobile_number rescue ""),
        # :EMAIL_ID => (epd.email_address rescue ""),
        # :CURR_ADD_ADDRESS => [eaf.address_street_number, eaf.address_street_name, eaf.street_type.abbreviation].join(" "),
        # :CURR_ADD_SUBURB => eaf.address_suburb,
        # :CURR_ADD_STATE => Constants::STATE_CODES.select{|z| z[:title] == eaf.address_state.to_s}.first[:code],
        # :CURR_ADD_POSTAL_CODE => eaf.address_post_code,
        # :CURR_ADD_DURATION_YRS => Date.today.year - eaf.moved_into_address_at.year,
        # :CURR_ADD_DURATION_MNTH => (Date.today.year * 12 + Date.today.month) - (eaf.moved_into_address_at.year * 12 + eaf.moved_into_address_at.month),
        # :PRESENT_EMPLOYER => (entity.personal_employments.first.employers_name rescue ""),
        # :PRESENT_EMP_CONT_NO => (entity.personal_employments.first.payroll_contact_phone_number rescue ""),
        # :'PRESENT_EMP_CONT_PERSON xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (([entity.personal_employments.first.payroll_contact_first_name, entity.personal_employments.first.payroll_contact_last_name].join(" ")) rescue ""),
        # :PRESENT_EMP_DURATION_YRS => ((Date.today.year - entity.personal_employments.first.began_employment_at.year) rescue ""),
        # :PRESENT_EMP_DURATION_MNTH => (((Date.today.year * 12 + Date.today.month) - (entity.personal_employments.first.began_employment_at.year * 12 + entity.personal_employments.first.began_employment_at.month)) rescue "" ),
        # :TOTAL_MONTHLY_INCOME => (entity.entity_personal_finances.net_income rescue ""),
        # :TOTAL_INCOME => (entity.entity_personal_finances.net_income rescue ""),
        # :'LANDLORD xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (eaf.landlord_or_agents_name rescue ""),
        # :'PROPERTY_CONT_NO xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (eaf.landlord_or_agents_phone rescue ""),
      }


    else
      ## Consumer Code:

      

      customer_details = {
        :PROSPECT_TYPE => entity[:customer_type], #CUSTOMER_TYPES
        :PROSPECT_RELATION => entity[:customer_relation], #CUSTOMER_TYPES
        :TITLE => entity[:title], #TITLE_CODES
        :GENDER => entity[:gender], #GENDER
        :D_O_BBIRTH => entity[:date_of_birth], #to_datetime
        :FIRST_NAME => entity[:first_name],
        #:'MIDDLE_NAME xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (entity[:middle_name] rescue ""),
        :LAST_NAME => entity[:last_name],
        :MARITIAL_STATUS => entity[:marital_status], #MARITAL_STATUS
        #:'N_O_DEPENDENTS xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => entity[:number_of_dependents],
        :AUSTRALIAN_RESIDENT => entity[:australian_resident], #AUSTRALIAN_RESIDENT
        :LICENSE_NO => entity[:drivers_licence_no],
        :LICENSE_STATE => entity[:drivers_licence_state] , #STATE_CODES
        :MOBILE_NO => (entity[:mobile_number] rescue ""),
        :EMAIL_ID => (entity[:email] rescue ""),
        :CURR_ADD_ADDRESS => entity[:street_address], #unformatted street address
        :CURR_ADD_SUBURB => entity[:suburb],
        :CURR_ADD_STATE => entity[:state], #STATE_CODES
        :CURR_ADD_POSTAL_CODE => entity[:post_code],
        :CURR_ADD_DURATION_YRS => entity[:address_duration_years], #in years
        :CURR_ADD_DURATION_MNTH => entity[:address_duration_months], #in months
        :PRESENT_EMPLOYER => (entity[:employers_name] rescue ""),
        #:'PRESENT_EMP_CONT_PERSON xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (entity[:employer_contact] rescue ""),
        :PRESENT_EMP_DURATION_YRS => (entity[:employment_duration_years] rescue ""),
        :PRESENT_EMP_DURATION_MNTH => (entity[:employment_duration_months] rescue "" ),
        :TOTAL_MONTHLY_INCOME => (entity[:net_income]rescue ""),
        :TOTAL_INCOME => (entity[:net_income] rescue ""),
        #:'LANDLORD xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (entity_hash[:landlord] rescue ""),
        #:'PROPERTY_CONT_NO xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (entity_hash[:landlord_phone] rescue ""),
      }

      # if entity.entity_addresses.count > 1
      #   eaf2 = entity.entity_addresses[1]
      #   customer_details = customer_details.merge( :PREV_ADD_ADDRESS => [eaf2.address_street_number, eaf2.address_street_name, eaf2.street_type.abbreviation].join(" ") )
      #   customer_details = customer_details.merge( :PREV_ADD_SUBURB => eaf2.address_suburb )
      #   customer_details = customer_details.merge( :PREV_ADD_STATE => Constants::STATE_CODES.select{|z| z[:title] == eaf2.address_state.to_s}.first[:code] )
      #   customer_details = customer_details.merge( :PREV_ADD_POSTAL_CODE => eaf2.address_post_code )
      #   customer_details = customer_details.merge( :PREV_ADD_DURATION_YRS =>  eaf2.moved_into_address_at.year - eaf2.moved_into_address_at.year )
      #   customer_details = customer_details.merge( :PREV_ADD_DURATION_MNTH => (eaf.moved_into_address_at.year * 12 + eaf.moved_into_address_at.month) - (eaf2.moved_into_address_at.year * 12 + eaf2.moved_into_address_at.month) )
      # end

      # if entity.personal_employments.count > 1
      #  epe2 =  entity.personal_employments[1]
      #   customer_details = customer_details.merge( :'PREV_EMPLOYER xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => epe2.employers_name )
      #   customer_details = customer_details.merge( :'PREV_EMP_DURATION_YRS xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => (entity.personal_employments.first.began_employment_at.year - epe2.began_employment_at.year))
      #   customer_details = customer_details.merge( :'PREV_EMP_DURATION_MNTH xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"' => ((entity.personal_employments.first.began_employment_at.year * 12 + entity.personal_employments.first.began_employment_at.month) - (epe2.began_employment_at.year * 12 + epe2.began_employment_at.month)) )
      #   customer_details = customer_details.merge( :'PREV_EMP_CONT_NO xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'=> ( epe2.payroll_contact_phone_number rescue "" ) )
      # end
    end

    customerdetails = {
      :'CO-APPLICANT' => "OPTNO",
      :CUSTOMER_DETAILS => customer_details,
      :TOTAL_MONTHLY_INCOME_AMOUNT => (entity[:net_income] rescue 0 )

    }

    return customerdetails
  end
  
  def to_dom(node, data, attrs={})
    doc = Nokogiri::XML::Builder.new do |builder|
      if data.is_a? Hash
        builder.send(node, attrs) do
          data.keys.each do |k|
            builder  << to_dom(k, data[k]).root.to_xml
          end
        end
      else
        builder.send(node, data)
      end
    end
    doc.doc
  end


  def add_envelope(data)

    begin_envelope = "<?xml version=\"1.0\" encoding=\"utf-16\"?>
                      <soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">
                        <soap:Body>
                          <CreateApplication xmlns=\"http://tempuri.org/\">"

    end_envelope = "</CreateApplication>
                  </soap:Body>
                </soap:Envelope>"

    begin_envelope + data + end_envelope
  end
  


  def bmw_alphera_errors
    error_array = []

    unless self.application_motor_vehicle.present?
      error_array << 'Only motor vehicle applications are supported.'
    end

    platform = self.user.try(:company).try(:aggregator).try(:platform)
    unless platform.mfl?
      error_array << "The application's user platform does not support BMW/Alphera."
    end

    # unless current_user.bmw_alphera_enabled == true
    #   error_array << "The application's user does not support Bmw/Alphera."
    # end

    error_array
  end

  def bmw_alphera_supported?
    bmw_alphera_errors.blank?
  end


  def to_soap
    if self.access
      body = {
            :APPLICATIONSUMMARY => build_application_summary,
            :QUOTEDETAILS => build_quote_details,
            :CUSTOMERDETAILS => build_customer_details
          }
      doc = to_dom('CREATEAPPLICATION_EXTERNAL', body, {:'xmlns' => "CreateApplication_Input.xsd"})
      self.xml = doc.root.to_xml
      self.soap = add_envelope(self.xml)
    else
      "No access details"
    end
  end

  def post
    if self.soap
      bmw_url = "https://proxy1uat.bmwfinance.com.au/BizTalk_External_Interface_Proxy/BizTalk_External_Interface_DFE_External_Interface_Orchestration_BMWDFE_AU.asmx"
      headers = {'Content-Type' => 'text/xml', 'Accept' => 'text/xml'}
      HTTParty.post(bmw_url, :body => self.soap, :headers => headers)
    else
      "No soap to post"
    end
  end

end