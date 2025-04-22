{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "developer-hub.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "developer-hub.labels" -}}
helm.sh/chart: {{ include "developer-hub.chart" . }}
{{ include "developer-hub.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
argocd.argoproj.io/managed-by: openshift-gitops 
{{- end }}

{{/*
Selector labels
*/}}
{{- define "developer-hub.selectorLabels" -}}
app.kubernetes.io/name: {{ include "developer-hub.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: developer-hub
argocd.argoproj.io/managed-by: openshift-gitopss
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "developer-hub.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "developer-hub.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}