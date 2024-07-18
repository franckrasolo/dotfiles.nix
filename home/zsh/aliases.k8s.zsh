alias k="kubectl"

# CKAD / CKA / CKS
alias ka="kubectl apply"
alias kc="kubectl config use-context"
alias kd="kubectl delete --force --grace-period=0"
alias kr="kubectl replace --force --grace-period=0"
#alias kx="kubectl explain --recursive"
alias kx="kubectl explore"
alias kw="watch -n .7 kubectl"

export dro="--dry-run=client --output=yaml"
export now="--force --grace-period=0"
