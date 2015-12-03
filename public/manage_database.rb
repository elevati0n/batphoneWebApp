    timestamp="Tue Nov  26 16:02:31 EST 2015"

    
# Open JSON file
  File.open("public/database_migration.json", 'r') do |f|
# Parse the JSON file
        f.each do |line|
          json = JSON.parse(line)
                json.each do |hash|
#puts hash
                        hash.keys.each do |key|
#puts key
                                hash[key].each do |inner_hash|
#                               key.to_a
                                @temp = Object.const_get(key).new
#                               @temp = key.new

                                        inner_hash.keys.each do |inner_key|
puts inner_hash
#puts inner_hash[inner_key]
puts "before it"
#                                       @temp.send(inner_key) = inner_hash[inner_key]
                                        @temp.update_attributes(inner_hash)
puts "after it"
#                                       puts inner_hash[inner_key]
# puts                  inner_hash
                                        end
                                @temp.save
                                end
                        end
                end
#                 puts instance_attribute
#                end
         end



    #Create an array of models
    models = [User, Device,Group,Network,Micropost,Comment,Relationship,Recording]
    models.to_a
    #Create an array for storing json data
    final_json = []
    #Iterate through each model
    models.each do |model|
        # Create an array of attributes
        model_attributes = model.column_names
	# Create an array for a specific model
	events_json = []
	# Initiate a json array
	json_model = {}
        # iterate inside each model
        model.all.each do |event|
            # compare the timestamp to figure out if its new:
            if event.updated_at > timestamp
                # insert the current model instance into the teporary json array  
                event_json = {}
               # Iterate through each attribute of model instances and store them into a json array
		 model_attributes.each do |model_attribute|
          	     event_json[model_attribute]=event.send(model_attribute)
#                local_model = event.to_json	
		end
		# Store each model instance( e.g. user) into json array
		 events_json << event_json
            end
        end
#  	puts events_json
		json_model[model]=events_json
                 final_json << json_model

    end
   #write model json to the actual json file
    File.open("public/database_migration.json","w") do |f|
        f.write(final_json.to_json)
    end 

  end
