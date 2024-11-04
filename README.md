# Graph RAG with GCP and LlamaIndex

Forked off of this example:
<a href="https://colab.research.google.com/github/run-llama/llama_index/blob/main/docs/docs/examples/query_engine/knowledge_graph_rag_query_engine.ipynb" target="_parent"><img src="https://colab.research.google.com/assets/colab-badge.svg" alt="Open In Colab"/></a>

Do Graph RAG with GCP Tooling

![](./graph_output.png)

# Poetry dependency installation guide

Make sure poetry is installed

Run for requirements

```bash
poetry shell
poetry install
```

# Guide on starting and running Nebula Graph

## Deploy to Compute Engine


```bash
source .env
```

Then run 


```bash
gcloud compute instances create $VM_NAME \
--image-project=debian-cloud \
--image-family=debian-12 \
--metadata-from-file=startup-script=nebula_startup.sh
```

And then create the instance

Note the external IP Address create a secret:

```bash
printf xxx.xxx.xxx.xxx | gcloud secrets create nebula-ip --data-file=-
```

or to update,

```bash
... | gcloud secrets versions add nebula-ip --data-file=-
```

Lastly, ssh into the new VM and run the following:

```bash
/usr/local/nebula/bin/nebula-console -u root -p nebula -port 9669 -addr 127.0.0.1
```

In the console,

```sql
ADD HOSTS 127.0.0.1:9779
```

#### Manual Installation Instructions

[Installation](https://docs.nebula-graph.io/3.8.0/2.quick-start/2.install-nebula-graph/)
[Nebula Console Installation](https://github.com/vesoft-inc/nebula-console)
**Important - map storage to Nebula hosts as a one-time setup before your run the console commands from the notebook**

```bash
ADD HOSTS 127.0.0.1:9779
```

### Manual Installation Instructions

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