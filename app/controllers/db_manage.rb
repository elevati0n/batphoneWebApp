def db_manage
respond_to

    @networks = [:network_params]
     @users = [:users_params]
     @microposts = [:microposts_params]
     @recordings = [:recordings_params]
     @groups = [:groups_params]

end