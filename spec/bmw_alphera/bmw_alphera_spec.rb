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
  end

  describe '.send_data_bmw_alphera' do
    it "post the data" do
      request = BmwAlphera::Request.new
      expect(request.send_data_bmw_alphera(@access_hash)).to eq({})
    end
  end 
end