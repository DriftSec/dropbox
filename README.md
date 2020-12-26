# dropbox
Raspberry Pi dropbox for pen-testing 


This repo contains a set a scripts meant to be installed on a raspberry pi, and dropped on a client network during a pent-test.  
Once the dropbox is connected to the client network it will perform a series of tasks on the interanl network.  

Tasks that can be enabled:
- Reverse ssh tunnel (connect via "ssh -p [REVSSH_C2_LOCALPORT] [dropbox user]@localhost" on the C2)
- Reverse VPN connection (not done yet)
- Heralding (not done yet)
- responder (not done yet)
- ntlmrelay (not done yet)

# TODO
- add communication over DNS for when no outbound
- add outbound portscan (portquiz.net)

## Usage:
On the dropbox:
  ```
  1. configure SSH server on the dropbox for the user you want to use
  2. git clone https://github.com/DriftSec/dropbox.git /opt/dropbox
  3. configure settings in dropbox/config.txt
  4. add the following to crontab with sudo crontab -e
    @reboot sleep 5 && /opt/dropbox/dropbox.sh > /dev/null 2>&1
    */5 * * * * /opt/dropbox/dropbox.sh > /dev/null 2>&
  ```
   
On the C2 Server:
```
1. configure SSH on the C2 server to accept connections with a key from the dropbox

```# dropbox
Raspberry Pi dropbox for pen-testing 
