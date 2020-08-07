Use env to setup Required Port when creating container. And set local storage for data and configure files

Example:
docker run -d --restart=always --network host -e FASTDFS_IPADDR=10.68.4.193 -e TRACKER_PORT=22122 -e STORAGE_PORT=23000 -e NGINX_HTTP_PORT=8888 -v /data/docker/appdata/fastdfs/etc/fdfs:/etc/fdfs -v /data/docker/appdata/fastdfs/dfs:/home/dfs --name fastdfs tansong0091/fastdfs:0.3


10.68.4.193 #your host ip (This ip should be accessable from your java client)
/data/docker/appdata/fastdfs/etc/fdfs #your host path for data
/data/docker/appdata/fastdfs/dfs #your host path for configure files

NOTE: 
you must use cantainer network as host. if you use default network mode bridge you storage ip will pick up container internal ip and java client will get connection timeout error.