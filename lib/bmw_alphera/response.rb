class BmwAlphera::Response < ActiveRecord::Base
  self.table_name = "bmw_alphera_responses"
  belongs_to :request, dependent: :destroy, inverse_of: :response

  validates :request_id, presence: true
  validates :xml, presence: true
  validates :headers, presence: true
  validates :code, presence: true
  validates :success, presence: true

  after_initialize :to_hash

  def to_hash
    if self.xml
      self.as_hash = Hash.from_xml(self.xml)
    else
      "No hash was created because there was no xml"
    end
  end

  def error
    if self.xml && !self.success?
      self.xml 
    else
      "No error"
    end
  end

end