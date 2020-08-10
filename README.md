#############version 0.4#################
Avaible evn as following. you can set them when creating container.
TRACKER_IP
TRACKER_PORT
STORAGE_PORT
NGINX_HTTP_PORT
STORAGE_FLAG
TRACKER_FLAG
GROUP_NAME: default value "group1"

Example:
1. Enable all components(nginx, tracker and storage service)

docker run -d --restart=always --network host -e TRACKER_IP=10.68.4.193 -e TRACKER_PORT=22122 -e STORAGE_PORT=23000 -e NGINX_HTTP_PORT=8888 -v /data/docker/appdata/fastdfs/etc/fdfs:/etc/fdfs -v /data/docker/appdata/fastdfs/dfs:/home/dfs --name fastdfs tansong0091/fastdfs:0.4

2. Enable storage service
Note: In one group(like group1) you need to use same port for each storage

docker run -d --restart=always --network host -e TRACKER_IP=10.68.4.193 -e TRACKER_PORT=22122 -e STORAGE_PORT=23000 -e NGINX_HTTP_PORT=8888 -e STORAGE_FLAG=y -e GROUP_NAME=group1 -v /data/docker/appdata/fastdfs_storage/etc/fdfs:/etc/fdfs -v /data/docker/appdata/fastdfs_storage/dfs:/home/dfs --name fastdfs_storage tansong0091/fastdfs:0.4
 
3. Enable storage and tracker service
10.68.4.195 is host ip

docker run -d --restart=always --network host -e TRACKER_IP=10.68.4.195 -e TRACKER_PORT=22122 -e STORAGE_PORT=23000 -e NGINX_HTTP_PORT=8888 -e STORAGE_FLAG=y -e TRACKER_FLAG=y -e GROUP_NAME=group2 -v /data/docker/appdata/fastdfs_storage/etc/fdfs:/etc/fdfs -v /data/docker/appdata/fastdfs_storage/dfs:/home/dfs --name fastdfs_storage tansong0091/fastdfs:0.4


#############version 0.3#################
Use env to setup Required Port when creating container. And set local storage for data and configure files

Example:
docker run -d --restart=always --network host -e FASTDFS_IPADDR=10.68.4.193 -e TRACKER_PORT=22122 -e STORAGE_PORT=23000 -e NGINX_HTTP_PORT=8888 -v /data/docker/appdata/fastdfs/etc/fdfs:/etc/fdfs -v /data/docker/appdata/fastdfs/dfs:/home/dfs --name fastdfs tansong0091/fastdfs:0.3


10.68.4.193 #your host ip (This ip should be accessable from your java client)
/data/docker/appdata/fastdfs/etc/fdfs #your host path for data
/data/docker/appdata/fastdfs/dfs #your host path for configure files

NOTE: 
you must use cantainer network as host. if you use default network mode bridge you storage ip will pick up container internal ip and java client will get connection timeout error.