# env.sh - default variables (edit only if you want different)
export KUBE_NAMESPACE="devsecops-demo"
export ARGOCD_NS="argocd"
export ARGOCD_APP_NAME="mini-runrun"
export REPO_URL="git@github.com:Sandeepsardesi/mini-runrun-demo.git"
export SECRET_NAME="repo-ssh-mini-runrun"
export SSH_KEY_PATH="$HOME/.ssh/argocd-mini-runrun-2"
export KNOWN_HOSTS_PATH="/tmp/github_known_hosts"
export ARGOCD_SERVER_SVC="argocd-server"
export ARGOCD_PORT_FORWARD_LOCAL=8080
