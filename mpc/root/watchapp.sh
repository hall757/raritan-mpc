#!/bin/bash
# keep the app running in the session by relaunching it when it exits.
# For some unknown reason, the first time the app is launched, the screen
# is not painted correctly with openjdk.  So kill the first instance after 
# launching.  Acutally, just use the offical java and it just works.
export JAVAHOME=/$JDKHOME
mkdir -p /config/.java
chown -R nobody /config
cd /
echo "/$JDKVER" > path.conf
#state=0 # never been launched yet
while [ 1 ]
do
    pcount=$(ps ax --no-headers | grep -i mpc | grep -v grep | wc -l)
    #if [[ $state -eq 1 ]]
    #then
    #  ps ax --no-headers | grep -i "java.*mpc" | grep -v grep |awk '{print $1}' | xargs kill -9 
    #  state=2 # has been killed once
    #fi
    if [[ "$pcount" == "0" ]]
    then
      echo no mpc... starting
      ./start.sh
      #if [[ $state -eq 0 ]]
      #then
      #  state=1 # this is the first launch
      #else
      #  count=2 # has been killed once
      #fi
    fi
    sleep 5
done
