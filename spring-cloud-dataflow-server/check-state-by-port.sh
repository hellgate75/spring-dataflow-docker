#!/bin/sh
PING_SK_SRV_PORT="$(netstat -an|grep 7577)"
PING_DF_SRV_PORT="$(netstat -an|grep 9393)"
if [ "" != "$PING_DF_SRV_PORT" ]; then
   echo "Spring Cloud Data Flow Server is ACTIVE"
   echo "$PING_DF_SRV_PORT"
else
   echo "Spring Cloud Data Flow Server is OFFLINE"
fi
if [ "" != "$PING_SK_SRV_PORT" ]; then
   echo "Spring Cloud Skipper Server is ACTIVE"
   echo "$PING_SK_SRV_PORT"
else
   echo "Spring Cloud Skipper Server is OFFLINE"
fi
