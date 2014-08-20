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

  it { should have_one(:response).dependent(:destroy) }

  describe '.to_soap' do
    it "converts to xml" do
      request = BmwAlphera::Request.new
      xml = request.to_soap(@access_hash)
      p xml
      expect(xml).to_not eq({})
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