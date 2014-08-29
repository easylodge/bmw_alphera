ActiveRecord::Schema.define do
self.verbose = false

  create_table :bmw_alphera_requests do |t|
    t.integer :application_id
    t.text :xml
    t.text :soap
    t.string :access
    t.text :entity
    t.text :quote
    t.timestamps
  end

  create_table :bmw_alphera_responses  do |t|
    t.text :headers
    t.integer :code
    t.text :xml
    t.boolean :success
    t.integer :request_id
    t.timestamps
  end
end