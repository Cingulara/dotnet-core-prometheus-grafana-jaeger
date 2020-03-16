# dotnet-core-prometheus-grafana-jaeger
A demonstration of using .NET Core 2.2, Prometheus, Grafana, and Jaeger with APIs to show metrics, tracing, etc.

# How to Run
Run `docker-compose up` in the folder you pulled this down into.

# Servers and Ports Setup
8082 - People API

8084 - Locations API

9090 - Prometheus UI

3000 - Grafana UI

# Prometheus setup
The Prometheus YML gets added with a volume mount into Prometheus. Inside the Compose file, we have the APIs internally running on 8080 and then exposing them outside of Docker as different ports. You use the "internal to the network" name and port to access the APIs internally. 

```
global:
  scrape_interval:     10s # By default, scrape targets every 10 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  # external_labels:
  #   monitor: 'nats-openrmf-server'

# A scrape configuration containing exactly one endpoint to scrape:
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'peopleapi-read-prometheus'
    # metrics_path defaults to '/metrics'
    static_configs:
    # replace the IP with your local IP for development
    # localhost is not it, as that is w/in the container :)
    - targets: ['peopleapi:8080']
  - job_name: 'locationsapi-read-prometheus'
    # metrics_path defaults to '/metrics'
    static_configs:
    # replace the IP with your local IP for development
    # localhost is not it, as that is w/in the container :)
    - targets: ['locationsapi:8080']
```

# Prerequisites
To use this project you need to have Docker, Docker Compose, and .NET Core 2.2 setup on whatever computer you wish to use.

# Logging Output
You should see something like below if you run `docker-compose up` and spit logs out to the screen.  When done, use CTRL+C to stop it and run `docker-compose down` to clean up the containers, the network, the services, etc.

```
peopleapi_1     | 2020-03-16 12:11:44.4809|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 3.6869ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://peopleapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:11:51.1554|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://locationsapi:8080/metrics   |url: http://locationsapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:11:51.1592|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 3.774ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://locationsapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:11:54.4768|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://peopleapi:8080/metrics   |url: http://peopleapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:11:54.4798|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 2.9553ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://peopleapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:01.1536|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://locationsapi:8080/metrics   |url: http://locationsapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:01.1651|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 11.4668ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://locationsapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:12:04.4775|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://peopleapi:8080/metrics   |url: http://peopleapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:12:04.4818|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 4.3375ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://peopleapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:11.1317|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://locationsapi:8080/metrics   |url: http://locationsapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:11.1352|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 3.5845ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://locationsapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:12:14.4568|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://peopleapi:8080/metrics   |url: http://peopleapi/metrics|action: 
peopleapi_1     | 2020-03-16 12:12:14.4679|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 11.1177ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://peopleapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:21.1317|1|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request starting HTTP/1.1 GET http://locationsapi:8080/metrics   |url: http://locationsapi/metrics|action: 
locationsapi_1  | 2020-03-16 12:12:21.1387|2|INFO|Microsoft.AspNetCore.Hosting.Internal.WebHost|Request finished in 6.9127ms 200 text/plain; version=0.0.4; charset=utf-8 |url: http://locationsapi/metrics|action: 

```