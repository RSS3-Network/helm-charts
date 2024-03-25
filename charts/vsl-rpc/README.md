# vsl-rpc Helm Chart

This Helm chart deploys vsl-rpc on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.18+
- Helm 3.9.0

## Installing the Chart

To install the chart with the release name `my-release`:

### Add RSS3 Helm repository

```bash
helm repo add rss3 https://rss3-network.github.io/helm-charts
```

### Install the chart

```bash
helm install my-release rss3/vsl-rpc
```

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
helm uninstall my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the vsl-rpc chart and their default values.

| Parameter                             | Description                                  | Default Value                            |
| ------------------------------------- | -------------------------------------------- | ---------------------------------------- |
| replicaCount                          | Number of replicas for the deployment        | 1                                        |
| imagePullSecrets                      | Secrets to use for pulling the image         | []                                       |
| nameOverride                          | Override name for the deployment             | ""                                       |
| fullnameOverride                      | Override full name for the deployment        | ""                                       |
| clusterDomain                         | Domain for the cluster                       | cluster.local                            |
| updateStrategy.type                   | Update strategy type                         | RollingUpdate                            |
| podManagementPolicy                   | Pod management policy for the deployment     | Parallel                                 |
| networkId                             | Network ID                                   | 12553                                    |
| jwt.path                              | Path for JWT                                 | "/config/jwt-secret.txt"                 |
| sequencerhttp                         | URL for sequencer                            | "http://sequencer"                       |
| geth.genesis.path                     | Path for Geth genesis file                   | "/config/genesis.json"                   |
| geth.genesis.url                      | URL for Geth genesis file (if applicable)    | ""                                       |
| geth.dataDir                          | Data directory for Geth                      | "/data"                                  |
| geth.image.repository                 | Geth image repository                        | rss3/op-geth                             |
| geth.image.pullPolicy                 | Geth image pull policy                       | IfNotPresent                             |
| geth.image.tag                        | Geth image tag                               | rss3-main-1ecad30                        |
| geth.ports.auth.addr                  | Address for Geth authentication port         | "0.0.0.0"                                |
| geth.ports.auth.port                  | Port for Geth authentication                 | 8551                                     |
| geth.ports.http.enable                | Enable HTTP port for Geth                    | true                                     |
| geth.ports.http.addr                  | Address for Geth HTTP port                   | "0.0.0.0"                                |
| geth.ports.http.port                  | Port for Geth HTTP                           | 8545                                     |
| geth.ports.http.api                   | Geth HTTP API options                        | "web3,debug,eth,txpool,net,engine"       |
| geth.ports.http.vhosts                | Allowed virtual hosts for Geth HTTP          | "\*"                                     |
| geth.ports.metric.enable              | Enable metric port for Geth                  | true                                     |
| geth.ports.metric.addr                | Address for Geth metric port                 | "0.0.0.0"                                |
| geth.ports.metric.port                | Port for Geth metric                         | 7300                                     |
| node.autoDiscovery                    | Enable auto-discovery for OP Node            | true                                     |
| node.rollup.path                      | Path for OP Node rollup file                 | "/config/rollup.json"                    |
| node.rollup.url                       | URL for OP Node rollup file (if applicable)  | ""                                       |
| node.p2p.privateKeyPath               | Path for OP Node P2P private key             | "/config/opnode_p2p_priv.txt"            |
| node.p2p.peerStorePath                | Path for OP Node P2P peer store              | "/op_log/opnode_peerstore_db"            |
| node.p2p.discoveryPath                | Path for OP Node P2P discovery               | "/op_log/opnode_discovery_db"            |
| node.image.repository                 | OP Node image repository                     | rss3/op-node                             |
| node.image.pullPolicy                 | OP Node image pull policy                    | IfNotPresent                             |
| node.image.tag                        | OP Node image tag                            | d2c5ced00901227473fc196fda838191f0cb4e02 |
| node.ports.rpc.addr                   | Address for OP Node RPC port                 | "0.0.0.0"                                |
| node.ports.rpc.port                   | Port for OP Node RPC                         | 9545                                     |
| node.ports.p2p.addr                   | Address for OP Node P2P port                 | "0.0.0.0"                                |
| node.ports.p2p.port                   | Port for OP Node P2P                         | 9003                                     |
| node.ports.metric.enable              | Enable metric port for OP Node               | true                                     |
| node.ports.metric.addr                | Address for OP Node metric port              | "0.0.0.0"                                |
| node.ports.metric.port                | Port for OP Node metric                      | 7301                                     |
| proxyd.enabled                        | Enable proxyd component                      | false                                    |
| proxyd.image.repository               | Proxyd image repository                      | rss3/proxyd                              |
| proxyd.image.pullPolicy               | Proxyd image pull policy                     | IfNotPresent                             |
| proxyd.image.tag                      | Proxyd image tag                             | d2c5ced00901227473fc196fda838191f0cb4e02 |
| proxyd.ports.rpc.addr                 | Address for proxyd RPC port                  | "0.0.0.0"                                |
| proxyd.ports.rpc.port                 | Port for proxyd RPC                          | 9045                                     |
| configs.geth.create                   | Create Geth config                           | true                                     |
| configs.geth.verbosity                | Verbosity level for Geth                     | 3                                        |
| configs.geth.nodiscover               | Disable peer discovery for Geth              | true                                     |
| ... (other Geth config options)       |                                              |                                          |
| configs.node.create                   | Create OP Node config                        | true                                     |
| ... (other OP Node config options)    |                                              |                                          |
| storage.hostPath                      | Host path for storage                        | ""                                       |
| storage.recovery.enabled              | Enable storage recovery                      | false                                    |
| storage.recovery.snapshotName         | Name of storage recovery snapshot            | ""                                       |
| storage.persistentVolume.size         | Size of persistent volume                    | 500Gi                                    |
| storage.persistentVolume.storageClass | Storage class for persistent volume          | ""                                       |
| serviceAccount.create                 | Create Kubernetes service account            | true                                     |
| serviceAccount.automount              | Automatically mount API credentials          | true                                     |
| service.type                          | Kubernetes service type                      | ClusterIP                                |
| ... (other service config options)    |                                              |                                          |
| volumes                               | Additional volumes for the deployment        | []                                       |
| initContainers                        | Initialization containers for the deployment | []                                       |
| nodeSelector                          | Node selector for the deployment             | {}                                       |
| tolerations                           | Tolerations for the deployment               | []                                       |
| affinity                              | Affinity settings for the deployment         | {}                                       |
