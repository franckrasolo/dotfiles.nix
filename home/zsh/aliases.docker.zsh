#alias containers:remove='docker rm -vf $(docker ps --all --quiet)'
#alias containers:remove='docker rm -vf $(diff --unchanged-group-format='%<' --old-group-format='' --new-group-format='' --changed-group-format='' <(docker ps --quiet | sort) <(docker ps --all --quiet | sort))'
alias containers:remove='docker rm -vf $(comm -13 <(docker ps --quiet | sort) <(docker ps --all --quiet | sort))'

#alias docker:context="printf 'FROM scratch\nCOPY . /' | docker buildx build -f - -o /tmp/docker-context . && tree /tmp/docker-context"
alias docker:context="docker buildx build -f Dockerfile ../../../.. -t docker-context && docker run --rm docker-context cat /tmp/docker-context && docker rmi -f docker-context"

alias images:remove='docker rmi -f $(docker images --filter "dangling=true" --quiet --no-trunc)'
