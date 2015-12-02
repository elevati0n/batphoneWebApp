    timestamp="Tue Nov  26 16:02:31 EST 2015"

    #Create an array of models
    #models = ["User", "Device", "Group","Network","Micropost","Comment","Relationship","Recording"]
    #Iterate through each model
    #models.each do |model|
        #Create an array for storing json data  
        events_json=[]
        #Create an array of attributes
        model_attributes = User.column_names
	puts model_attributes
        # iterate inside each model
        User.all.each do |event|
            #compare the timestamp to figure out if its new:
            if event.updated_at > timestamp
		puts event
                #insert the current model instance into the teporary json array  
                event_json = {}
                model_attributes.each do |model_attribute|
               	     puts model_attribute
		     puts event.send(model_attribute)
		     event_json[model_attribute]=event.send(model_attribute)
		end
		 events_json << event_json
#		events_json << event_json
            end
        end
   # end
   #write model json to the actual json file
    File.open("public/database_migration.json","w") do |f|
        f.write(events_json.to_json)
    end 
    
