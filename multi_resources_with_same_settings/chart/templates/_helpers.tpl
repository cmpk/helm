{{/*
[description]
  オブジェクトから指定したキーの値を取得する。
  指定したキーがない場合は、ルートオブジェクトから指定したキーの値を取得する。
[arguments]
  place    : 取得したい値のキー名。ドットで連結可能。例： "key1.key2.key3"
  root     : .Value を指定する
  settings : place で指定したキーを持つオブジェクト
[return]
  文字列。キーがない場合や値がない場合は空文字。
*/}}
{{- define "getValue" -}}
{{- $keys := (splitList "." .place) }}
{{- $ret := include "getValueRecursive" (dict "settings" .settings "keys" $keys) }}
{{- $ret | default (include "getValueRecursive" (dict "settings" .root "keys" $keys)) -}}
{{- end }}

{{- define "getValueRecursive" -}}
{{- if .settings }}
{{- if and (eq (len .keys) 1) (hasKey .settings (first .keys)) }}
{{- index .settings (first .keys) }}
{{- else if gt (len .keys) 1 }}
{{- $len := len .keys }}
{{- $key := (first .keys) }}
{{- include "getValueRecursive" (dict "settings" (index .settings $key) "keys" (slice .keys 1 $len)) }}
{{- end }}
{{- end }}
{{- end }}

{{/*
[description]
  オブジェクトに指定したキーの値が存在するか確認する。
[arguments]
  place    : 取得したい値のキー名。ドットで連結可能。例： "key1.key2.key3"
  settings : place で指定したキーを持つオブジェクト
[return]
  "true"または空文字列。
  値が空オブジェクト、空リスト、空文字のいずれか、または、指定したキーがない場合、空文字列。
[note]
  if文で true / false を判定しやすいよう、キーの値が存在しない場合は空文字列を返すようにした。
  例 : if include "hasValues" (dict "settings" .settings "place" .place)
*/}}
{{- define "hasValues" -}}
{{- $keys := (splitList "." .place) }}
{{- $ret := include "getValueRecursive" (dict "settings" .settings "keys" $keys) }}
{{- if $ret }}
true
{{- end }}
{{- end }}
