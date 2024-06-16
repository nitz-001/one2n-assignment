#! /bin/bash

timestamp=$(date +"%Y%m%d%H%M%S")
filename="/metrics/metrics-$timestamp.txt"
if wget -qO- http://node-exporter.observability.svc.cluster.local:9100/metrics > $filename; 
then
  echo "Metrics stored in $filename"
else
  echo "Failed to store metrics in $filename" >&2
  rm $filename
fi