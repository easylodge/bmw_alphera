class BmwAlphera::Response < ActiveRecord::Base
  self.table_name = "bmw_alphera_responses"
  belongs_to :request, dependent: :destroy, inverse_of: :response

  serialize :headers
  serialize :as_hash


end