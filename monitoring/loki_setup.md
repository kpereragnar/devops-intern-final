# Loki Monitoring Setup

## 1. Overview

This monitoring stack collects NGINX container logs from the Nomad deployment using Promtail, stores and indexes them in Loki, and makes them searchable through Grafana.

### Architecture

```text
Nomad
  |
  v
NGINX Docker Container
  |
  v
Docker JSON Logs
  |
  v
Promtail
  |
  v
Loki (Port 3100)
  |
  v
Grafana (Port 3000)
```

## 2. Components and Versions

| Component | Image | Version |
|---|---|---|
| Loki | grafana/loki | 3.7.9 |
| Promtail | grafana/promtail | 3.6.11 |
| Grafana | grafana/grafana | 13.3.0 |

## 3. Starting the Monitoring Stack

From the project root, run:

```bash
docker compose -f monitoring/docker-compose.yaml up -d
```

Verify the containers:

```bash
docker compose -f monitoring/docker-compose.yaml ps
```

Check Loki readiness:

```bash
curl http://127.0.0.1:3100/ready
```

Check Grafana health:

```bash
curl http://127.0.0.1:3000/api/health
```

## 4. Accessing Grafana

Open:

http://127.0.0.1:3000

The Loki data source is automatically provisioned through:

`monitoring/grafana/provisioning/datasources/loki.yaml`

The configured internal URL is:

`http://loki:3100`

Navigate to Explore and select Loki.

## 5. Log Labels

Promtail discovers Docker containers and filters for containers carrying a Nomad allocation ID.

The following labels are attached to collected logs:

| Label | Description |
|---|---|
| job | Log collection job (`nginx`) |
| service | Nomad service name (`nginx-app`) |
| container | Docker container name |
| nomad_alloc_id | Nomad allocation identifier |
| service_name | Service metadata detected by Loki |

## 6. LogQL Queries

### Display all NGINX logs

```logql
{job="nginx"}
```

### Filter HTTP 404 responses

```logql
{job="nginx"} |= "404"
```

### Filter logs belonging to the NGINX service

```logql
{service="nginx-app"}
```

### Filter by Nomad allocation

```logql
{nomad_alloc_id="YOUR_ALLOCATION_ID"}
```

## 7. Generating Test Logs

Generate a successful request:

```bash
curl -i http://127.0.0.1:25363/
```

Generate a 404 response:

```bash
curl -i http://127.0.0.1:25363/monitoring-test-404
```

The port above is dynamically assigned by Nomad. Replace it with the current allocation's host port when necessary.

Use the LogQL queries in Grafana Explore to verify ingestion.

## 8. Stopping the Monitoring Stack

```bash
docker compose -f monitoring/docker-compose.yaml down
```

To remove monitoring volumes and their stored data:

```bash
docker compose -f monitoring/docker-compose.yaml down -v
```

**Warning:** The second command deletes persistent Loki, Promtail position, and Grafana data.

## 9. Security and Operational Limitations

- Loki authentication is disabled for this isolated local lab.
- Loki and Grafana are bound to localhost and should not be exposed publicly without appropriate security controls.
- Promtail requires access to the Docker socket for container discovery. A read-only socket mount does not make Docker API operations read-only.
- Promtail reached end of life on 2 March 2026. It is retained here because the assessment specifically requires Promtail. Grafana Alloy should be evaluated for future production deployments.
- Loki uses local filesystem storage, single-node operation, and seven-day log retention. This is not a highly available production architecture.
- Nomad and Consul are running in development mode in this lab. Their in-memory state is not persistent across agent restarts.

## 10. Evidence

Grafana Explore screenshot:

`docs/screenshots/06-grafana-explore.png`

The screenshot demonstrates NGINX log ingestion and HTTP 404 filtering through Loki.
