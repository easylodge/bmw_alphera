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
        :user_id => config["user_password"]
      }
  end

  it { should belong_to(:request).dependent(:destroy) }

end