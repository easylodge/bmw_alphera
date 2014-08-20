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
    @quote_hash = 
      {
        :brand_code => 'PBALP',
        :status_code => "ASUSE"
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
        it "saves brand_code" do
          expect(@request.xml).to include('<BRANDCODE>PBALP</BRANDCODE>')
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