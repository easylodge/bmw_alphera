class CreateBmwAlpheraRequest < ActiveRecord::Migration
  def self.up
    create_table :bmw_alphera_requests do |t|
      t.text :xml
      t.text :soap
      t.text :access
      t.text :entity
      t.text :quote
      
      t.timestamps
    end
  end
  
  def self.down
    drop_table :bmw_alphera_requests
  end
end