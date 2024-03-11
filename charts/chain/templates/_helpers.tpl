{{/*
Expand the name of the chart.
*/}}
{{- define "vsl-chain.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vsl-chain.fullname" -}}
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
{{- define "vsl-chain.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vsl-chain.labels" -}}
helm.sh/chart: {{ include "vsl-chain.chart" .context }}
{{ include "vsl-chain.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
{{- if .context.Chart.AppVersion }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vsl-chain.selectorLabels" -}}
{{- if .name -}}
app.kubernetes.io/name: {{ include "vsl-chain.name" .context }}-{{ .name }}
{{ end -}}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
{{- end }}

{{/*
Global config check sum
*/}}
{{- define "vsl-chain.globalConfigCheckSum" -}}
{{ include (print $.Template.BasePath "/configmap.yaml") . | sha256sum }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vsl-chain.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vsl-chain.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create vsl-chain geth name and version as used by the chart label.
*/}}
{{- define "vsl-chain.geth.fullname" -}}
{{- printf "%s-%s" (include "vsl-chain.fullname" .) .Values.geth.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create vsl-chain node name and version as used by the chart label.
*/}}
{{- define "vsl-chain.node.fullname" -}}
{{- printf "%s-%s" (include "vsl-chain.fullname" .) .Values.node.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create vsl-chain proxyd name and version as used by the chart label.
*/}}
{{- define "vsl-chain.proxyd.fullname" -}}
{{- printf "%s-%s" (include "vsl-chain.fullname" .) .Values.proxyd.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create vsl-chain batcher name and version as used by the chart label.
*/}}
{{- define "vsl-chain.batcher.fullname" -}}
{{- printf "%s-%s" (include "vsl-chain.fullname" .) .Values.batcher.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create vsl-chain proposer name and version as used by the chart label.
*/}}
{{- define "vsl-chain.proposer.fullname" -}}
{{- printf "%s-%s" (include "vsl-chain.fullname" .) .Values.proposer.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
