#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

echo ">> port-forwarding argocd server svc/${ARGOCD_SERVER_SVC} to localhost:${ARGOCD_PORT_FORWARD_LOCAL}"
kubectl -n "${ARGOCD_NS}" port-forward svc/"${ARGOCD_SERVER_SVC}" "${ARGOCD_PORT_FORWARD_LOCAL}":443
