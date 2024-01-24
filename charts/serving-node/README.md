# Serving-Node Helm Chart

## Get Repo Info

```console
helm repo add rss3 https://rss3-network.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Installing the Chart

To install the chart with the release name `my-release`:

```console
helm install my-release rss3/serving-node
```

## Uninstalling the Chart

To uninstall/delete the my-release deployment:

```console
helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration values for serving-node.

### Globally shared configuration
| Parameter                               | Description                                                                 | Default Value |
|-----------------------------------------|-----------------------------------------------------------------------------|---------------|
| global.additionalLabels                 | Common labels for all resources                                             | {}            |
| global.revisionHistoryLimit             | Number of old deployment ReplicaSets to retain                              | 3             |
| global.image.repository                 | Default image repository used by all components                             | rss3/node     |
| global.image.tag                        | Overrides the default image tag whose default is the chart appVersion       | ""            |
| global.image.imagePullPolicy            | Image pull policy applied to all RSS3 node deployments                      | IfNotPresent  |
| global.imagePullSecrets                 | Secrets with credentials to pull images from a private registry             | []            |
| global.statefulsetAnnotations           | Annotations for all deployed Statefulsets                                   | {}            |
| global.deploymentAnnotations            | Annotations for all deployed Deployments                                    | {}            |
| global.podAnnotations                   | Annotations for all deployed pods                                           | {}            |
| global.podLabels                        | Labels for all deployed pods                                                | {}            |
| global.securityContext                  | Toggle and define pod-level security context                                | {}            |
| global.hostAliases                      | Mapping between IP and hostnames that will be injected in pod's hosts files | []            |
| global.networkPolicy.create             | Create NetworkPolicy objects for all components                             | false         |
| global.networkPolicy.defaultDenyIngress | Default deny all ingress traffic                                            | false         |
| global.priorityClassName                | Default priority class for all components                                   | ""            |
| global.nodeSelector                     | Default node selector for all components                                    | {}            |
| global.tolerations                      | Default tolerations for all components                                      | {}            |
| global.affinity                         | Default affinity preset for all components                                  | {}            |

### Hub
| Parameter                      | Description                                    | Default Value    |
|--------------------------------|------------------------------------------------|------------------|
| hub.name                       | RSS3 Node hub name                             | hub              |
| hub.replicaCount               | Number of replicas                             | 1                |
| hub.image.repository           | Image repository                               | rss3/node        |
| hub.image.pullPolicy           | Image pull policy                              | IfNotPresent     |
| hub.image.tag                  | Image tag                                      | ""               |
| hub.imagePullSecrets           | Image pull secrets                             | []               |
| hub.deploymentAnnotations      | Annotations to be added to server Deployment   | {}               |
| hub.podAnnotations             | Annotations to be added to server pods         | {}               |
| hub.podLabels                  | Labels to be added to server pods              | {}               |
| hub.resources                  | Resource limits and requests for the Hub       | {}               |
| hub.serviceAccount.create      | Create server service account                  | true             |
| hub.serviceAccount.name        | Server service account name                    | serving-node-hub |
| hub.serviceAccount.annotations | Annotations applied to created service account | {}               |

### BroadCaster
| Parameter                         | Description                                      | Default Value |
|-----------------------------------|--------------------------------------------------|---------------|
| broadcaster.enabled               | Whether BroadCaster is enabled                   | false         |
| broadcaster.name                  | BroadCaster name                                 | broadcaster   |
| broadcaster.replicaCount          | Number of replicas                               | 1             |
| broadcaster.image.repository      | Image repository                                 | rss3/node     |
| broadcaster.image.pullPolicy      | Image pull policy                                | IfNotPresent  |
| broadcaster.image.tag             | Image tag                                        | ""            |
| broadcaster.imagePullSecrets      | Image pull secrets                               | []            |
| broadcaster.deploymentAnnotations | Annotations to be added to server Deployment     | {}            |
| broadcaster.podAnnotations        | Annotations to be added to server pods           | {}            |
| broadcaster.podLabels             | Labels to be added to server pods                | {}            |
| broadcaster.resources             | Resource limits and requests for the BroadCaster | {}            |

## Node Configs
| Parameter                    | Description            | Default Value |
|------------------------------|------------------------|---------------|
| configs.environment          | Node environment       | development   |
| configs.discovery.maintainer | Maintainer information |               |
| configs.discovery.server     | Server information     |               |
| configs.annotations          | Annotations            | {}            |

### Node Indexer
| Parameter | Description   | Default Value |
|-----------|---------------|---------------|
| indexers  | Node indexers | []            |

### RSSHub
| Parameter      | Description               | Default Value |
|----------------|---------------------------|---------------|
| rsshub.enabled | Whether RSSHub is enabled | false         |

For more information, please view [rsshub helm chart](https://github.com/NaturalSelectionLabs/helm-charts/tree/main/charts/rsshub)

### Additional RSS
| Parameter     | Description                        | Default Value |
|---------------|------------------------------------|---------------|
| additionalRSS | Additional RSS feeds configuration | []            |

### Database
| Parameter          | Description           | Default Value                             |
|--------------------|-----------------------|-------------------------------------------|
| database.driver    | Database driver       | cockroachdb                               |
| database.partition | Database partitioning | true                                      |
| database.uri       | Database URI          | postgres://root@localhost:26257/defaultdb |

### Stream
| Parameter     | Description                  | Default Value   |
|---------------|------------------------------|-----------------|
| stream.enable | Whether streaming is enabled | false           |
| stream.driver | Stream driver                | kafka           |
| stream.topic  | Stream topic                 | rss3.node.feeds |
| stream.uri    | Stream URI                   | localhost:9092  |

### Observability
| Parameter                   | Description                                                      | Default
