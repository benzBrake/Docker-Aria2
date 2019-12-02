# Docker-Aria2
Run Aria2 base in docker container

# What is Aria2
aria2 is a lightweight multi-protocol & multi-source command-line download utility. It supports HTTP/HTTPS, FTP, SFTP, BitTorrent and Metalink. aria2 can be manipulated via built-in JSON-RPC and XML-RPC interfaces.

# How to use this image
1. Create your data directory(default is /data/aria2).
2. Download docker-compose.yml to /data/
3. RUN command
```
# cd /data/
# docker-compose up -d
```

# Tips
1. Before you run this image, you can put your aria2.conf in `/data/aria2`
2. Default download direcotry is `/data/aria2/downloads/`

# Thanks
Aria2 executable file is from [@q3aql](https://github.com/q3aql/aria2-static-builds "@q3aql").

# Feedback
If you have any problems with or questions about this image, please contact me through a GitHub [issue](https://github.com/benzBrake/Dockerfiles/issues "issue").