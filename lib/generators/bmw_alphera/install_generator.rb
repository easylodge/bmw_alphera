module BmwAlphera
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      source_root File.expand_path("../../templates", __FILE__)

      def self.next_migration_number(dirname)
        Time.new.utc.strftime("%Y%m%d%H%M%S")
      end
      
      def create_migration_file
        #copy migration
        migration_template "migration_bmw_alphera_request.rb", "db/migrate/create_bmw_alphera_request.rb"
        sleep 1
        migration_template "migration_bmw_alphera_response.rb", "db/migrate/create_bmw_alphera_response.rb"
        
      end
    end
  end
end