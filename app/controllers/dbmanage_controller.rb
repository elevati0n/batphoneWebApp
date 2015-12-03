class DbmanageController < ApplicationController

 def db_manage
   require_relative "/var/www/batphone2/batphoneWebApp/public/manage_database.rb"
   system "load 'manage_database.rb'"
   @@data = File.read("public/database_migration.json")
   render :json => @@data
 end

end
