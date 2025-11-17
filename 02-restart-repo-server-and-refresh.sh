#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

echo ">> restart argocd repo-server to pick up secret/configmap"
kubectl -n "${ARGOCD_NS}" rollout restart deployment argocd-repo-server

echo ">> wait for repo-server to be available (timeout 2m)"
kubectl -n "${ARGOCD_NS}" wait --for=condition=available --timeout=120s deployment/argocd-repo-server || true

echo ">> force ArgoCD to refresh application '${ARGOCD_APP_NAME}'"
kubectl -n "${ARGOCD_NS}" annotate application "${ARGOCD_APP_NAME}" argocd.argoproj.io/refresh="hard" --overwrite || true

echo ">> tail last 150 lines of repo-server logs (for quick debugging)"
POD=$(kubectl -n "${ARGOCD_NS}" get pod -l app.kubernetes.io/name=argocd-repo-server -o jsonpath='{.items[0].metadata.name}')
kubectl -n "${ARGOCD_NS}" logs "${POD}" -c argocd-repo-server --tail=150 || true

echo "Done."
