# Ephemeral Kubernetes: kind + vcluster + Headlamp

Spin up a local **kind** host, an isolated **vcluster**, and the **Headlamp** dashboard with a ready-to-use token and port-forward. Built for fast demos and repeatable dev environments.

```mermaid
architecture-beta
    group root(cloud)[Root Cluster]
    service rootKong(server)[Kong] in root

    group vCluster1(server)[Ephemeral Cluster 1] in root
    service vCluster1Kong(server)[Kong] in vCluster1
    service vCluster1Argo(server)[Argo] in vCluster1
    service vCluster1Platform(server)[Platform] in vCluster1
    vCluster1Kong:L -- R:vCluster1Platform
    vCluster1Kong:T -- R:vCluster1Argo

    group vCluster2(server)[Ephemeral Cluster 2] in root
    service vCluster2Kong(server)[Kong] in vCluster2
    service vCluster2Argo(server)[Argo] in vCluster2
    service vCluster2Platform(server)[Platform] in vCluster2
    vCluster2Kong:R -- L:vCluster2Platform
    vCluster2Kong:T -- L:vCluster2Argo
    rootKong:L -- R:vCluster1Kong
    rootKong:R -- L:vCluster2Kong
```

## How to deploy

- `just all` — creates kind `$HOST`, deploys vcluster `$VNAME`, generates kubeconfig, installs Headlamp, port-forwards to `http://localhost:$VPORT`, saves token at `vcluster/$VNAME/.dashboard.token.txt`.
- `just cluster-create` — creates only the kind cluster `$HOST`.

## How to stop

- `just cluster-delete` — deletes the kind cluster `$HOST` and cleans `./vcluster`.
