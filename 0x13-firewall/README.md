<<<<<<< HEAD
0x13. Firewall ALX task
=======
This is a 0x13. Firewall ALX task
>>>>>>> a1281483aca006125c34385c91f56afc82452033

0. Let’s install the ufw firewall and setup a few rules on web-01.

Requirements:

The requirements below must be applied to web-01 (feel free to do it on lb-01 and web-02, but it won’t be checked)
Configure ufw so that it blocks all incoming traffic, except the following TCP ports:
22 (SSH)
443 (HTTPS SSL)
80 (HTTP)
Share the ufw commands that you used in your answer file
<<<<<<< HEAD
File: File: 0-block_all_incoming_traffic_but
=======
File: 0-block_all_incoming_traffic_but
>>>>>>> a1281483aca006125c34385c91f56afc82452033

1. Firewalls can not only filter requests, they can also forward them.

Requirements:

Configure web-01 so that its firewall redirects port 8080/TCP to port 80/TCP.
Your answer file should be a copy of the ufw configuration file that you modified to make this happen
My web server nginx is only listening on port 80
netstat shows that nothing is listening on 8080
I use curl to query web-01.holberton.online, and since my firewall is forwarding the ports, I get a HTTP 200 response on port 80/TCP and also on port 8080/TCP.
File: 100-port_forwarding
