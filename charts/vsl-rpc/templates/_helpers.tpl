{{/*
Expand the name of the chart.
*/}}
{{- define "vsl-rpc.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vsl-rpc.fullname" -}}
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
{{- define "vsl-rpc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vsl-rpc.labels" -}}
helm.sh/chart: {{ include "vsl-rpc.chart" . }}
{{ include "vsl-rpc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vsl-rpc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vsl-rpc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vsl-rpc.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vsl-rpc.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
VSL Node Script Name
*/}}
{{- define "vsl-rpc.scripts.name" -}}
{{- printf "%s-%s" (include "vsl-rpc.fullname" .) "scripts" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Geth Configuration Name
*/}}
{{- define "vsl-rpc.config-name.geth" -}}
{{- printf "%s-%s" (include "vsl-rpc.fullname" .) "geth" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Geth Configuration Values
*/}}
{{- define "vsl-rpc.config.geth" -}}
{{- $config := omit .Values.configs.geth "create" "annotations" -}}
{{- range $key, $value := $config }}
{{- $fmted := $value | toString }}
{{- if not (eq $fmted "") }}
{{ $key }}: {{ $fmted | quote }}
{{- end }}
{{- end }}
{{- end -}}

{{/*
Node Configuration Name
*/}}
{{- define "vsl-rpc.config-name.node" -}}
{{- printf "%s-%s" (include "vsl-rpc.fullname" .) "node" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Node Configuration Values
*/}}
{{- define "vsl-rpc.config.node" -}}
{{- $config := omit .Values.configs.node "create" "annotations" -}}
{{- range $key, $value := $config }}
{{- $fmted := $value | toString }}
{{- if not (eq $fmted "") }}
{{ $key }}: {{ $fmted | quote }}
{{- end }}
{{- end }}
{{- end -}}