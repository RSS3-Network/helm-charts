{{/*
Expand the name of the chart.
*/}}
{{- define "rss3-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "rss3-node.fullname" -}}
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
{{- define "rss3-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "rss3-node.labels" -}}
helm.sh/chart: {{ include "rss3-node.chart" .context }}
{{ include "rss3-node.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rss3-node.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "rss3-node.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Global config check sum
*/}}
{{- define "rss3-node.globalConfigCheckSum" -}}
{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "rss3-node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "rss3-node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create rss3-node hub name and version as used by the chart label.
*/}}
{{- define "rss3-node.hub.fullname" -}}
{{- printf "%s-%s" (include "rss3-node.fullname" .) .Values.hub.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the Argo CD server service account to use
*/}}
{{- define "rss3-node.hub.ServiceAccountName" -}}
{{- if .Values.hub.serviceAccount.create -}}
    {{ default (include "rss3-node.hub.fullname" .) .Values.hub.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.hub.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create rss3-node indexer fullname
*/}}
{{- define "rss3-node.indexer.name" -}}
{{- printf "%s-%s" .network .worker | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create rss3-node indexer fullname
*/}}
{{- define "rss3-node.indexer.fullname" -}}
{{- printf "%s-%s" (include "rss3-node.fullname" .context) (include "rss3-node.indexer.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Indexer labels
*/}}
{{- define "rss3-node.indexer.labels" -}}
helm.sh/chart: {{ include "rss3-node.chart" .context }}
{{ include "rss3-node.indexer.selectorLabels" (dict "context" .context "component" .component "indexer" .indexer) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "rss3-node.indexer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "rss3-node.name" .context }}-{{ include "rss3-node.indexer.name" .indexer }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}
{{ include "rss3-node.indexer.commonLabels" .indexer }}
{{- end }}

{{/*
Common indexer labels
*/}}
{{- define "rss3-node.indexer.commonLabels" -}}
{{- if .network }}
node.rss3.io/network: {{ .network }}
{{- end }}
{{- if .worker }}
node.rss3.io/worker: {{ .worker }}
{{- end }}
{{- end }}

{{/*
Create rss3-node hub name and version as used by the chart label.
*/}}
{{- define "rss3-node.broadcaster.fullname" -}}
{{- printf "%s-%s" (include "rss3-node.fullname" .) .Values.broadcaster.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}