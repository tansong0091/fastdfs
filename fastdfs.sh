#!/bin/bash
    

if [ ! -f /temp/fdfs/firstsetup ];then
    #new_val=$FASTDFS_IPADDR
    #old="com.ikingtech.ch116221"

    sed -i "s/<old_TRACKER_IP_FOR_CLIENT>/$TRACKER_IP/g" /temp/fdfs/client.conf
    sed -i "s/<old_TRACKER_PORT_FOR_CLIENT>/$TRACKER_PORT/g" /temp/fdfs/client.conf

    sed -i "s/<old_TRACKER_IP_FOR_STORAGE>/$TRACKER_IP/g" /temp/fdfs/storage.conf
    sed -i "s/<old_TRACKER_PORT_FOR_STORAGE>/$TRACKER_PORT/g" /temp/fdfs/storage.conf
    sed -i "s/<old_STORAGE_PORT>/$STORAGE_PORT/g" /temp/fdfs/storage.conf
    sed -i "s/<old_NGINX_HTTP_PORT>/$NGINX_HTTP_PORT/g" /temp/fdfs/storage.conf   

    sed -i "s/<old_TRACKER_IP_FOR_MOD>/$TRACKER_IP/g" /temp/fdfs/mod_fastdfs.conf
    sed -i "s/<old_TRACKER_PORT_FOR_MOD>/$TRACKER_PORT/g" /temp/fdfs/mod_fastdfs.conf

    sed -i "s/<old_TRACKER_PORT>/$TRACKER_PORT/g" /temp/fdfs/tracker.conf
    sed -i "s/<old_NGINX_HTTP_PORT>/$NGINX_HTTP_PORT/g" /temp/fdfs/tracker.conf

    sed -i "s/<old_NGINX_HTTP_PORT>/$NGINX_HTTP_PORT/g" /temp/fdfs/nginx.conf	

    cat  /temp/fdfs/client.conf > /temp/fdfs/client.txt
    cat  /temp/fdfs/storage.conf >  /temp/fdfs/storage.txt
    cat  /temp/fdfs/mod_fastdfs.conf > /temp/fdfs/mod_fastdfs.txt

    cp /temp/fdfs/* /etc/fdfs

    mv /usr/local/nginx/conf/nginx.conf /usr/local/nginx/conf/nginx.conf.t
    cp /etc/fdfs/nginx.conf /usr/local/nginx/conf
    touch /temp/fdfs/firstsetup
fi

if [ x$NODETYPE = x ];then
    echo "start trackerd"
    /etc/init.d/fdfs_trackerd start
    echo Track ip:port: $TRACKER_IP:$TRACKER_PORT

    echo "start storage"
    /etc/init.d/fdfs_storaged start
    echo Storage ip:port: $TRACKER_IP:$STORAGE_PORT

    echo "start nginx"
    /usr/local/nginx/sbin/nginx 
    echo Nginx ip:port: $TRACKER_IP:$NGINX_HTTP_PORT
elif [ x$NODETYPE = xstorage ];then
    echo "start storage"
    /etc/init.d/fdfs_storaged start
    echo Storage ip:port: Your host ip:$STORAGE_PORT
fi

tail -f  /dev/null
