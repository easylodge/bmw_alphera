class CreateBmwAlpheraResponse < ActiveRecord::Migration
  def self.up
    create_table :bmw_alphera_responses do |t|
      t.text :headers
      t.integer :code
      t.text :xml
      t.text :as_hash
      t.boolean :success
      t.integer :request_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :bmw_alphera_responses
  end
end