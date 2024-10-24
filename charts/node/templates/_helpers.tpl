{{/*
Expand the name of the chart.
*/}}
{{- define "node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "node.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "node.labels" -}}
helm.sh/chart: {{ include "node.chart" .context }}
{{ include "node.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node.name" .context }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Global config check sum
*/}}
{{- define "node.globalConfigCheckSum" -}}
{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the redis service account to use
*/}}
{{- define "node.redis.serviceAccountName" -}}
{{- if .Values.redis.serviceAccount.create -}}
    {{ default (include "node.redis.fullname" .) .Values.redis.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.redis.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create node core name and version as used by the chart label.
*/}}
{{- define "node.core.fullname" -}}
{{- printf "%s-%s" (include "node.fullname" .) .Values.core.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the Argo CD server service account to use
*/}}
{{- define "node.core.ServiceAccountName" -}}
{{- if .Values.core.serviceAccount.create -}}
    {{ default (include "node.core.fullname" .) .Values.core.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.core.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create node worker fullname
*/}}
{{- define "node.worker.name" -}}
{{- printf "%s" .id | replace "_" "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create node worker fullname
*/}}
{{- define "node.worker.fullname" -}}
{{- printf "%s-%s" (include "node.fullname" .context) (include "node.worker.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Indexer labels
*/}}
{{- define "node.worker.labels" -}}
helm.sh/chart: {{ include "node.chart" .context }}
{{ include "node.worker.selectorLabels" (dict "context" .context "component" .component "worker" .worker) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "node.worker.selectorLabels" -}}
app.kubernetes.io/name: {{ include "node.name" .context }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}
{{ include "node.worker.commonLabels" .worker }}
{{- end }}

{{/*
Common worker labels
*/}}
{{- define "node.worker.commonLabels" -}}
{{- if .network }}
node.rss3.io/network: {{ .network }}
{{- end }}
{{- if .worker }}
node.rss3.io/worker: {{ .worker }}
{{- end }}
{{- end }}

{{/*
Create node broadcaster name and version as used by the chart label.
*/}}
{{- define "node.broadcaster.fullname" -}}
{{- printf "%s-%s" (include "node.fullname" .) .Values.broadcaster.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create node monitorx name and version as used by the chart label.
*/}}
{{- define "node.monitorx.fullname" -}}
{{- printf "%s-%s" (include "node.fullname" .) .Values.monitorx.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create node monitorx name and version as used by the chart label.
*/}}
{{- define "node.redis.fullname" -}}
{{- printf "%s-%s" (include "node.fullname" .) .Values.redis.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
