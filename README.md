# dotnet-core-prometheus-grafana-jaeger
A demonstration of using .NET Core 2.2, Prometheus, Grafana, and Jaeger with APIs to show metrics, tracing, etc.

# Prometheus setup
The Prometheus YML gets added with a volume mount into Prometheus. Inside the Compose file, we have the APIs internally running on 8080 and then exposing them outside of Docker as different ports. You use the "internal to the network" name and port to access the APIs internally. 

```
global:
  scrape_interval:     10s # By default, scrape targets every 5 seconds.

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