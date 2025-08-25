# Ephemeral Kubernetes: kind + vcluster + Headlamp

Spin up a local **kind** host, an isolated **vcluster**, and the **Headlamp** dashboard with a ready-to-use token and port-forward. Built for fast demos and repeatable dev environments.

```mermaid
flowchart LR
    root-kong[Kong]

    root-kong---cluster1-kong
    root-kong---cluster2-kong

    subgraph cluster1[Ephemeral Cluster 1]
        cluster1-kong[Kong]
        cluster1-argo[Argo]
        cluster1-view[View]

        cluster1-kong---cluster1-view
        cluster1-kong---cluster1-argo
    end

    subgraph cluster2[Ephemeral Cluster 2]
        cluster2-kong[Kong]
        cluster2-argo[Argo]
        cluster2-view[View]

        cluster2-kong---cluster2-view
        cluster2-kong---cluster2-argo
    end
```

## How to deploy

- `just all` — creates kind `$HOST`, deploys vcluster `$VNAME`, generates kubeconfig, installs Headlamp, port-forwards to `http://localhost:$VPORT`, saves token at `vcluster/$VNAME/.dashboard.token.txt`.
- `just cluster-create` — creates only the kind cluster `$HOST`.

## How to stop

- `just cluster-delete` — deletes the kind cluster `$HOST` and cleans `./vcluster`.
