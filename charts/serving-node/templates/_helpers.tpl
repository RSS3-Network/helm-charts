{{/*
Expand the name of the chart.
*/}}
{{- define "serving-node.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "serving-node.fullname" -}}
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
{{- define "serving-node.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "serving-node.labels" -}}
helm.sh/chart: {{ include "serving-node.chart" .context }}
{{ include "serving-node.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "serving-node.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "serving-node.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Global config check sum
*/}}
{{- define "serving-node.globalConfigCheckSum" -}}
{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "serving-node.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "serving-node.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create serving-node hub name and version as used by the chart label.
*/}}
{{- define "serving-node.hub.fullname" -}}
{{- printf "%s-%s" (include "serving-node.fullname" .) .Values.hub.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the Argo CD server service account to use
*/}}
{{- define "serving-node.hub.ServiceAccountName" -}}
{{- if .Values.hub.serviceAccount.create -}}
    {{ default (include "serving-node.hub.fullname" .) .Values.hub.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.hub.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create serving-node indexer fullname
*/}}
{{- define "serving-node.indexer.name" -}}
{{- printf "%s-%s" .network .worker | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create serving-node indexer fullname
*/}}
{{- define "serving-node.indexer.fullname" -}}
{{- printf "%s-%s" (include "serving-node.fullname" .context) (include "serving-node.indexer.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Indexer labels
*/}}
{{- define "serving-node.indexer.labels" -}}
helm.sh/chart: {{ include "serving-node.chart" .context }}
{{ include "serving-node.indexer.selectorLabels" (dict "context" .context "component" .component "indexer" .indexer) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "serving-node.indexer.selectorLabels" -}}
app.kubernetes.io/name: {{ include "serving-node.name" .context }}-{{ include "serving-node.indexer.name" .indexer }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}
{{ include "serving-node.indexer.commonLabels" .indexer }}
{{- end }}

{{/*
Common indexer labels
*/}}
{{- define "serving-node.indexer.commonLabels" -}}
{{- if .network }}
node.rss3.io/network: {{ .network }}
{{- end }}
{{- if .worker }}
node.rss3.io/worker: {{ .worker }}
{{- end }}
{{- end }}

{{/*
Create serving-node hub name and version as used by the chart label.
*/}}
{{- define "serving-node.broadcaster.fullname" -}}
{{- printf "%s-%s" (include "serving-node.fullname" .) .Values.broadcaster.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}