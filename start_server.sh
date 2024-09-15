#!/bin/bash

# hugo server --gc --noHTTPCache --watch --disableFastRender

##################################
## get LOCAL_IP if not already set 
## stolen from https://stackoverflow.com/questions/53113171/how-can-i-determine-the-ip-address-from-a-bash-script

## Windows
LOCAL_IP=${LOCAL_IP:-`ipconfig.exe | grep -im1 'IPv4 Address' | cut -d ':' -f2 | sed 's/^\s*//;s/\s*$//'`}

## Linux
## LOCAL_IP=${LOCAL_IP:-`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p' | sed 's/^\s*//;s/\s*$//'`}

## MacOS
## LOCAL_IP=${LOCAL_IP:-`ipconfig getifaddr en0 | sed 's/^\s*//;s/\s*$//'`} #en0 for host and en1 for wireless


##################################
## start server
## use 0.0.0.0 to bind so we can use both localhost and the actual local ip to access the site 
## (needed for connectinv via local network)
hugo server -D --gc --noHTTPCache --watch --disableFastRender --port 1313 --bind 0.0.0.0 --baseURL http://$LOCAL_IP