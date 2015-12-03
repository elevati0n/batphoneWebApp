#run on pi to make a tunnel to gateway
#ssh -L [port to share on] : [hostIPtoShare:hostporttoshare] [host?]
ssh -L 19922:129.10.248.216:2222 129.10.248.216
ssh -R 19922:129.10.248.216:2222 129.10.248.216

#
ssh -L 19922:batphone.co:22 batphone.co
		18880

847


ssh -R 19922:batphone.co:22 batphone.co

#
ssh -i .ssh/id_dsa.db -L 19922:192.168.2.4:22 192.168.2.4


#ssh into meshnet
#ssh -R 10022:localhost:22 HostA

ssh -R 10022:localhost:22 129.10.248.216 -p 2222

ssh -R 10022:localhost:22 batphone.co 

#run this on the gateway?
ssh -i /etc/dropbear/dropbear_rsa_host_key -R 18879:localhost:2222 batphone.co


debug1: Local connections to LOCALHOST:18881 forwarded to remote address 129.10.248.216:2222


