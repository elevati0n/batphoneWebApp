sudo apt-get update
sudo apt-get install -y git curl zlib1g-dev subversion

sudo apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
sudo apt-get install -y libyaml-dev libsqlite3-dev sqlite3
sudo apt-get install -y libxml2-dev libxslt-dev
sudo apt-get install -y autoconf automake libtool bison

#check the integrity of the files using pgp
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

#get the rvm if this fails halt 
curl -L get.rvm.io | bash -s stable --rails

