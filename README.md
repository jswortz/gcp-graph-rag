#### Guide on starting and running Nebula Graph

##### Prerequisites

[Installation](https://docs.nebula-graph.io/3.8.0/2.quick-start/2.install-nebula-graph/)
[Nebula Console Installation](https://github.com/vesoft-inc/nebula-console)
**Important - map storage to Nebula hosts as a one-time setup before your run the console commands from the notebook**

```bash
ADD HOSTS 127.0.0.1:9779
```

##### Instructions

1. Start the server

```bash
sudo /usr/local/nebula/scripts/nebula.service start all
```

2. Check the server is running and up

```bash
sudo /usr/local/nebula/scripts/nebula.service status all
```

3. Stop the server when done

```bash
sudo /usr/local/nebula/scripts/nebula.service stop all
```

##### Tips

SSH Port forward from another server running Nebula Graph by using the `-L9669:localhost:9669` SSH arguments