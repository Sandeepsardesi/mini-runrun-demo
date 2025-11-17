#!/usr/bin/env bash
set -euo pipefail
source ./env.sh || true

echo ">> creating namespace ${KUBE_NAMESPACE} (if not exists)"
kubectl get ns "${KUBE_NAMESPACE}" >/dev/null 2>&1 || kubectl create ns "${KUBE_NAMESPACE}"

echo ">> generating known_hosts (github.com)"
ssh-keyscan -t rsa,ed25519 github.com > "${KNOWN_HOSTS_PATH}"
echo "known_hosts created at ${KNOWN_HOSTS_PATH}"

echo ">> apply argocd repo secret '${SECRET_NAME}' in ${ARGOCD_NS}"
kubectl -n "${ARGOCD_NS}" create secret generic "${SECRET_NAME}" \
  --from-literal=url="${REPO_URL}" \
  --from-file=sshPrivateKey="${SSH_KEY_PATH}" \
  --from-file=sshKnownHosts="${KNOWN_HOSTS_PATH}" \
  --dry-run=client -o yaml | kubectl -n "${ARGOCD_NS}" apply -f -

kubectl -n "${ARGOCD_NS}" label secret "${SECRET_NAME}" argocd.argoproj.io/secret-type=repository --overwrite

kubectl -n "${ARGOCD_NS}" create configmap argocd-ssh-known-hosts-cm --from-file=ssh_known_hosts="${KNOWN_HOSTS_PATH}" --dry-run=client -o yaml | kubectl -n "${ARGOCD_NS}" apply -f -

echo "Done."
