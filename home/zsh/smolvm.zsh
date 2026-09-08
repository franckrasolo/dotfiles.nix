#compdef smolvm

# zsh completion for the Smol Machines smolvm CLI (v1.14.3).
# Generated from recursive `smolvm <subcommand> --help` output and
# https://github.com/smol-machines/smol/blob/main/docs/cli.md
#
# Works both as an autoloadable fpath file (e.g. symlinked as `_smolvm`)
# and when sourced directly (registers itself via compdef).

_smolvm_help_opt=('(-h --help)'{-h,--help}'[Print help]')

_smolvm_cmds=(
  'machine:Manage machines (create, start, stop, exec)'
  'vm:Alias for machine'
  'serve:Start the HTTP API server for programmatic control'
  'pack:Package and run self-contained VM executables'
  'config:Manage smolvm configuration (registries, defaults)'
  'help:Print help for a command'
)

_smolvm_machine_cmds=(
  'run:Run a container image in an ephemeral machine'
  'exec:Run a command directly in the VM (not in a container)'
  'create:Create a new named machine configuration'
  'start:Start a machine'
  'branch:Branch a running branchable machine into an independent child (CoW memory + disks)'
  'checkpoint:Save a running machine, including RAM, as a portable checkpoint'
  'branch-release:Assign parameters and release one held branch-pool slot'
  'stop:Stop a running machine'
  'delete:Delete a machine configuration'
  'rm:Alias for delete'
  'status:Show machine status'
  'egress-events:Show egress denials — outbound connections the machine'"'"'s egress policy refused'
  'ls:List all machines'
  'list:Alias for ls'
  'update:Modify settings on a stopped machine (mounts, ports, resources, disks)'
  'images:List cached images and storage usage'
  'prune:Remove unused images and layers to free disk space'
  'shell:Open an interactive shell in a machine (starts it if stopped)'
  'sh:Alias for shell'
  'cp:Copy files between host and machine'
  'sync:Synchronize guest-local staged mounts back to their host directories'
  'monitor:Monitor a machine with health checks and restart policy'
  'data-dir:Print the on-disk data directory path for a named machine'
)

_smolvm_serve_cmds=(
  'start:Start the HTTP API server'
  'openapi:Export OpenAPI specification for SDK generation'
)

_smolvm_pack_cmds=(
  'create:Package an OCI image or VM snapshot into a self-contained executable'
  'run:Run a VM from a packed .smolmachine sidecar file'
  'push:Push a .smolmachine artifact to a registry'
  'pull:Pull a .smolmachine artifact from a registry'
  'inspect:Inspect a .smolmachine artifact in a registry (without downloading)'
  'prune:Clean up cached pack extractions to free disk space'
)

_smolvm_config_cmds=(
  'show:Show current configuration'
  'registries:Manage registry configuration'
)

_smolvm_config_registries_cmds=(
  'path:Show the path to the registries configuration file'
  'edit:Edit the registries configuration file in your default editor'
  'show:Show current registries configuration'
  'init:Create an example configuration file'
)

# --- helpers ---------------------------------------------------------------

# Print existing machine names, one per line.
_smolvm__machine_names() {
  (( $+commands[smolvm] )) || return 1
  command smolvm machine ls --json 2>/dev/null | command grep -o '"name": *"[^"]*"' | command cut -d'"' -f4
}

_smolvm_machine_names() {
  local -a names
  names=(${(f)"$(_smolvm__machine_names)"})
  (( $#names )) && _describe -t smolvm-machines 'machine' names
}

# machine cp SRC/DST: local paths plus machine:path references.
_smolvm_cp_path() {
  if compset -P '*:'; then
    _files
    return
  fi
  local -a names prefixes
  names=(${(f)"$(_smolvm__machine_names)"})
  prefixes=(${^names}'\:')
  _files
  (( $#prefixes )) && _describe -t smolvm-machine-paths 'machine path (machine:path)' prefixes -S ''
}

_smolvm_smolmachine() { _files -g '*.smolmachine(-.)' }
_smolvm_smolcheckpoint() { _files -g '*.smolcheckpoint(-.)' }
_smolvm_smolfile()    { _files -g 'Smolfile*(-.)' -g '*.toml(-.)' }

# --secret-env GUEST_VAR=HOST_VAR: complete exported host variables after "=".
_smolvm_secret_env() {
  if compset -P '*='; then
    local -a vars
    vars=(${(k)parameters[(R)*export*]})
    (( $#vars )) && _describe -t host-env-vars 'host environment variable' vars
  else
    _message -e guest-var 'GUEST_VAR=HOST_VAR'
  fi
}

# --secret-file GUEST_VAR=/abs/path: complete files after "=".
_smolvm_secret_file() {
  if compset -P '*='; then
    _files
  else
    _message -e guest-var 'GUEST_VAR=/absolute/path'
  fi
}

_smolvm_artifact_ref() {
  _message -e reference 'artifact reference (e.g. myapp:v1, registry.example.com/myapp:latest)'
}

_smolvm_block_io() {
  _values -s , 'block I/O engine' \
    'sync[Service one request at a time on the virtio block worker]' \
    'async[Submit queued raw-disk reads through a restricted Linux io_uring]'
}

# --- dispatchers -----------------------------------------------------------

_smolvm() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '(-V --version)'{-V,--version}'[Print version]' \
    '1:smolvm command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-commands 'smolvm command' _smolvm_cmds
      ;;
    args)
      case $words[1] in
        machine|vm) _smolvm_machine ;;
        serve)      _smolvm_serve ;;
        pack)       _smolvm_pack ;;
        config)     _smolvm_config ;;
        help)       _smolvm_help ;;
        *)          _describe -t smolvm-commands 'smolvm command' _smolvm_cmds ;;
      esac
      ;;
  esac
}

_smolvm_machine() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '1:machine command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-machine-commands 'machine command' _smolvm_machine_cmds
      ;;
    args)
      case $words[1] in
        run)              _smolvm_machine_run ;;
        exec)             _smolvm_machine_exec ;;
        create)           _smolvm_machine_create ;;
        start)            _smolvm_machine_start ;;
        branch|fork)      _smolvm_machine_branch ;;
        checkpoint)       _smolvm_machine_checkpoint ;;
        branch-release|fork-release) _smolvm_machine_branch_release ;;
        stop)             _smolvm_machine_stop ;;
        delete|rm)        _smolvm_machine_delete ;;
        status)           _smolvm_machine_status ;;
        egress-events)    _smolvm_machine_egress_events ;;
        ls|list)          _smolvm_machine_ls ;;
        update)           _smolvm_machine_update ;;
        images)           _smolvm_machine_images ;;
        prune)            _smolvm_machine_prune ;;
        shell|sh)         _smolvm_machine_shell ;;
        cp)               _smolvm_machine_cp ;;
        sync)             _smolvm_machine_sync ;;
        monitor)          _smolvm_machine_monitor ;;
        data-dir)         _smolvm_machine_data_dir ;;
        *)                _describe -t smolvm-machine-commands 'machine command' _smolvm_machine_cmds ;;
      esac
      ;;
  esac
}

_smolvm_serve() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '1:serve command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-serve-commands 'serve command' _smolvm_serve_cmds
      ;;
    args)
      case $words[1] in
        start)   _smolvm_serve_start ;;
        openapi) _smolvm_serve_openapi ;;
        *)       _describe -t smolvm-serve-commands 'serve command' _smolvm_serve_cmds ;;
      esac
      ;;
  esac
}

_smolvm_pack() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '1:pack command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-pack-commands 'pack command' _smolvm_pack_cmds
      ;;
    args)
      case $words[1] in
        create)  _smolvm_pack_create ;;
        run)     _smolvm_pack_run ;;
        push)    _smolvm_pack_push ;;
        pull)    _smolvm_pack_pull ;;
        inspect) _smolvm_pack_inspect ;;
        prune)   _smolvm_pack_prune ;;
        *)       _describe -t smolvm-pack-commands 'pack command' _smolvm_pack_cmds ;;
      esac
      ;;
  esac
}

_smolvm_config() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '1:config command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-config-commands 'config command' _smolvm_config_cmds
      ;;
    args)
      case $words[1] in
        show)       _arguments $_smolvm_help_opt ;;
        registries) _smolvm_config_registries ;;
        *)          _describe -t smolvm-config-commands 'config command' _smolvm_config_cmds ;;
      esac
      ;;
  esac
}

_smolvm_config_registries() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    $_smolvm_help_opt \
    '1:registries command:->command' \
    '*::argument:->args' && return 0

  case $state in
    command)
      _describe -t smolvm-config-registries-commands 'registries command' _smolvm_config_registries_cmds
      ;;
    args)
      case $words[1] in
        path|edit|show|init) _arguments $_smolvm_help_opt ;;
        *) _describe -t smolvm-config-registries-commands 'registries command' _smolvm_config_registries_cmds ;;
      esac
      ;;
  esac
}

_smolvm_help() {
  local context state line
  typeset -A opt_args

  _arguments -C \
    '1:topic:->topic' \
    '*::subtopic:->subtopic' && return 0

  case $state in
    topic)
      _describe -t smolvm-help-topics 'help topic' _smolvm_cmds
      ;;
    subtopic)
      if (( CURRENT == 2 )); then
        case $words[1] in
          machine|vm) _describe -t smolvm-help-topics 'machine help topic' _smolvm_machine_cmds ;;
          serve)      _describe -t smolvm-help-topics 'serve help topic' _smolvm_serve_cmds ;;
          pack)       _describe -t smolvm-help-topics 'pack help topic' _smolvm_pack_cmds ;;
          config)     _describe -t smolvm-help-topics 'config help topic' _smolvm_config_cmds ;;
        esac
      elif (( CURRENT == 3 )) && [[ $words[1] == config && $words[2] == registries ]]; then
        _describe -t smolvm-help-topics 'registries help topic' _smolvm_config_registries_cmds
      fi
      ;;
  esac
}

# --- machine ---------------------------------------------------------------

_smolvm_machine_run() {
  local context state line
  typeset -A opt_args

  _arguments \
    $_smolvm_help_opt \
    '(--from -I --image)'{-I,--image}'[Container image: registry reference, docker save archive (./img.tar, - for stdin) or rootfs dir; optional with a Smolfile or for bare VM mode]:image:_files' \
    '--max-image-size[Raise the max accepted local image-archive size (default 8GiB)]:size:(8GiB 16GiB 512M)' \
    '--init[Run command before the workload (repeatable; CLI form wins over Smolfile)]:command:_command_names -e' \
    '(-n --name)'{-n,--name}'[Name a persistent machine when used with --detach]:name:' \
    '(-d --detach)'{-d,--detach}'[Start the command in the background and detach, leaving the VM running]' \
    '(-i --interactive)'{-i,--interactive}'[Keep stdin open for interactive input]' \
    '(-t --tty)'{-t,--tty}'[Allocate a pseudo-TTY (use with -i for interactive shells)]' \
    '--timeout[Kill command after duration]:duration:(30s 5m 1h)' \
    '(-I --image)--from[Run a packed .smolmachine artifact ephemerally (discarded on exit)]:artifact:_smolvm_smolmachine' \
    '(-w --workdir)'{-w,--workdir}'[Set working directory inside container]:dir:_files -/' \
    '(-u --user)'{-u,--user}'[Run as this user, like docker run --user (a name or uid:gid)]:user:' \
    '*'{-e,--env}'[Set environment variable (repeatable)]:KEY=VALUE:' \
    '--oci-platform[Target OCI platform for multi-arch images]:platform:(linux/arm64 linux/amd64)' \
    '*'{-v,--volume}'[Mount host dir or S3 bucket (repeatable)]:HOST|REMOTE\:CONTAINER[\:ro|rw|staged]:_files -/' \
    '--allow-system-mounts[Allow trusted read-only host /etc and /var/log mounts below /host]' \
    '*'{-p,--port}'[Expose port or one-to-one range from container to host (repeatable)]:HOST[-END]\:GUEST[-END]:' \
    '--net[Enable outbound network access]' \
    '--net-backend[Select the networking backend]:backend:((tsi\:"Use libkrun TSI networking" virtio-net\:"Use virtio-net with the host-side smolvm network stack"))' \
    '--dns[Custom DNS resolver for the guest (implies --net)]:IP:' \
    '--network[Join a named inter-VM network (implies --net, virtio-net only)]:name:' \
    '*--allow-cidr[Allow egress to specific CIDR range (repeatable, implies --net)]:CIDR:' \
    '*--allow-host[Allow egress to specific hostname, resolved at VM start (repeatable, implies --net)]:hostname:' \
    '--outbound-localhost-only[Restrict outbound to localhost only (implies --net)]' \
    '--allow-host-loopback[Let the guest reach services on the host own loopback (implies --net)]' \
    '--docker-socket[Expose the guest Docker daemon socket to the host as a Unix socket]' \
    '--proxy[Proxy URL used for the in-VM image pull]:URL:' \
    '--no-proxy[Comma-separated NO_PROXY list that bypasses the proxy during image pull]:list:' \
    '--gpu[Enable GPU acceleration (Vulkan via virtio-gpu)]' \
    '--gpu-vram[GPU shared-memory region size in MiB (default 4096, ignored without --gpu)]:MiB:' \
    '--rosetta[Enable Rosetta 2 for x86_64 binary translation on Apple Silicon]' \
    '--cpus[Maximum vCPUs the machine may use (default 4)]:N:' \
    '--mem[Maximum memory in MiB the machine may use (default 8192)]:MiB:' \
    '--storage[Writable data disk size in GiB (default 20)]:GiB:' \
    '--overlay[Container rootfs overlay size in GiB]:GiB:' \
    '--block-io[Host block I/O engine]:engine:_smolvm_block_io' \
    '(-s --smolfile)'{-s,--smolfile}'[Load VM configuration from a Smolfile (TOML)]:Smolfile:_smolvm_smolfile' \
    '(--rebuild-init-cache)--no-init-cache[Skip the init-layer cache: re-run init on every ephemeral run]' \
    '(--no-init-cache)--rebuild-init-cache[Rebuild the cached init layer even if a matching one exists]' \
    '--ssh-agent[Forward host SSH agent into the VM (git/ssh without exposing keys)]' \
    '*--secret-env[Inject a secret from a host env var, resolved at launch (repeatable)]:GUEST_VAR=HOST_VAR:_smolvm_secret_env' \
    '*--secret-file[Inject a secret from a host file, resolved at launch (repeatable)]:GUEST_VAR=/abs/path:_smolvm_secret_file' \
    '--unprivileged[Run the workload as an unprivileged container (restricted capabilities, read-only cgroup)]' \
    '--cuda[Remote guest CUDA Driver-API calls to the host NVIDIA GPU over vsock]' \
    '--auto-graph[Ask compatible CUDA frameworks to graph safe compiled regions (implies --cuda)]' \
    '--docker-config[Mount ~/.docker config into the VM for registry authentication]' \
    '*:: :->command' && return 0

  if [[ $state == command ]]; then
    # `_arguments` keeps a literal `--` options terminator inside the
    # sub-command slice; drop it so _normal sees the guest command first.
    if [[ $words[1] == -- ]]; then
      shift words
      (( CURRENT > 1 )) && (( CURRENT-- ))
    fi
    _normal
    return
  fi
  return 1
}

_smolvm_machine_exec() {
  local context state line
  typeset -A opt_args

  _arguments \
    $_smolvm_help_opt \
    '--name[Target machine (default: "default")]:machine:_smolvm_machine_names' \
    '(-w --workdir)'{-w,--workdir}'[Set working directory in the VM]:dir:_files -/' \
    '(-u --user)'{-u,--user}'[Run as this user (a name or uid:gid)]:user:' \
    '*'{-e,--env}'[Set environment variable (repeatable)]:KEY=VALUE:' \
    '*--secret-env[Inject a secret from a host env var for this exec (repeatable)]:GUEST_VAR=HOST_VAR:_smolvm_secret_env' \
    '*--secret-file[Inject a secret from a host file for this exec (repeatable)]:GUEST_VAR=/abs/path:_smolvm_secret_file' \
    '--timeout[Kill command after duration]:duration:(30s 5m 1h)' \
    '(-d --detach --stream)'{-i,--interactive}'[Keep stdin open for interactive input]' \
    '(-d --detach --stream)'{-t,--tty}'[Allocate a pseudo-TTY (use with -i for shells)]' \
    '(-d --detach -i --interactive -t --tty)--stream[Stream output in real-time]' \
    '(-i --interactive -t --tty --stream)'{-d,--detach}'[Spawn the command in the background and return its PID immediately]' \
    '*:: :->command' && return 0

  if [[ $state == command ]]; then
    # `_arguments` keeps a literal `--` options terminator inside the
    # sub-command slice; drop it so _normal sees the guest command first.
    if [[ $words[1] == -- ]]; then
      shift words
      (( CURRENT > 1 )) && (( CURRENT-- ))
    fi
    _normal
    return
  fi
  return 1
}

_smolvm_machine_create() {
  local context state line
  typeset -A opt_args

  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Name for the machine (auto-generated if omitted)]:name:' \
    '*--label[Attach metadata to the machine, read back with machine ls --json (repeatable)]:KEY=VALUE:' \
    '(--from -I --image)'{-I,--image}'[Container image (e.g. alpine, python:3.12-alpine)]:image:_files' \
    '--max-image-size[Raise the max accepted local image-archive size (default 8GiB)]:size:(8GiB 16GiB 512M)' \
    '--cpus[Maximum vCPUs the machine may use (default 4)]:N:' \
    '--mem[Maximum memory in MiB the machine may use (default 8192)]:MiB:' \
    '--storage[Storage disk size in GiB (for OCI layers and container data)]:GiB:' \
    '--overlay[Overlay disk size in GiB (for persistent rootfs changes)]:GiB:' \
    '--block-io[Host block I/O engine]:engine:_smolvm_block_io' \
    '*'{-v,--volume}'[Mount host dir or S3 bucket (repeatable)]:HOST|REMOTE\:GUEST[\:ro|rw|staged]:_files -/' \
    '--allow-system-mounts[Allow trusted read-only host /etc and /var/log mounts below /host]' \
    '*'{-p,--port}'[Expose port or one-to-one range from VM to host (repeatable)]:HOST[-END]\:GUEST[-END]:' \
    '--net[Enable outbound network access]' \
    '--net-backend[Select the networking backend]:backend:((tsi\:"Use libkrun TSI networking" virtio-net\:"Use virtio-net with the host-side smolvm network stack"))' \
    '--dns[Custom DNS resolver for the guest (implies --net)]:IP:' \
    '--network[Join a named inter-VM network (implies --net, virtio-net only)]:name:' \
    '*--allow-cidr[Allow egress to specific CIDR range (repeatable, implies --net)]:CIDR:' \
    '*--allow-host[Allow egress to specific hostname, resolved at VM start (repeatable, implies --net)]:hostname:' \
    '--outbound-localhost-only[Restrict outbound to localhost only (implies --net)]' \
    '--gpu[Enable GPU acceleration (Vulkan via virtio-gpu)]' \
    '--gpu-vram[GPU shared-memory region size in MiB (default 4096, ignored without --gpu)]:MiB:' \
    '--rosetta[Enable Rosetta 2 for x86_64 binary translation on Apple Silicon]' \
    '*--expose-socket[Expose a guest Unix socket to the host (repeatable)]:GUEST_PATH[\:HOST_PATH]:' \
    '*--mount-socket[Mount a host Unix socket into the guest, HOST_PATH\:GUEST_PATH (repeatable)]:host socket:_files' \
    '*--init[Run command on every VM start (repeatable)]:command:_command_names -e' \
    '*'{-e,--env}'[Set environment variable (repeatable)]:KEY=VALUE:' \
    '(-u --user)'{-u,--user}'[Run the workload as this user, like docker run --user (a name or uid:gid)]:user:' \
    '--ssh-agent[Forward host SSH agent into the VM (git/ssh without exposing keys)]' \
    '--cuda[Remote guest CUDA Driver-API calls to the host NVIDIA GPU over vsock]' \
    '--auto-graph[Ask compatible CUDA frameworks to graph safe compiled regions (implies --cuda)]' \
    '--docker-socket[Expose the guest Docker daemon socket to the host as a Unix socket]' \
    '*--secret-env[Inject a secret from a host env var, resolved at each launch (repeatable)]:GUEST_VAR=HOST_VAR:_smolvm_secret_env' \
    '*--secret-file[Inject a secret from a host file, resolved at each launch (repeatable)]:GUEST_VAR=/abs/path:_smolvm_secret_file' \
    '(-s --smolfile)'{-s,--smolfile}'[Load configuration from a Smolfile (TOML)]:Smolfile:_smolvm_smolfile' \
    '(-I --image)--from[Create from a .smolmachine pack or restore a .smolcheckpoint]:artifact:_smolvm_smolmachine' \
    '*:: :->command' && return 0

  if [[ $state == command ]]; then
    # `_arguments` keeps a literal `--` options terminator inside the
    # sub-command slice; drop it so _normal sees the guest command first.
    if [[ $words[1] == -- ]]; then
      shift words
      (( CURRENT > 1 )) && (( CURRENT-- ))
    fi
    _normal
    return
  fi
  return 1
}

_smolvm_machine_start() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to start (default: "default")]:machine:_smolvm_machine_names' \
    '--branchable[Start as a branch source: memfd-backed RAM (CoW-cloneable) plus a control socket]' \
    '--branch-pool-size[Plan a CUDA branch pool with this many runnable children (implies --branchable)]:children:' \
    '--cuda-vram-limit-mib[Override the automatic logical VRAM budget per source/child CUDA session (requires --branch-pool-size)]:MiB:' \
    '--proxy[Proxy URL used for the in-VM image pull]:URL:' \
    '--no-proxy[Comma-separated NO_PROXY list that bypasses the proxy during image pull]:list:'
}

_smolvm_machine_branch() {
  _arguments \
    $_smolvm_help_opt \
    '--from[The running, branchable source machine to branch from]:machine:_smolvm_machine_names' \
    '(--name-prefix -n --name)'{-n,--name}'[Name for the new child machine]:name:' \
    '--count[Number of children to create from one checkpoint (default 1)]:count:' \
    '(-n --name)--name-prefix[Name batch children PREFIX-0 through PREFIX-(COUNT-1)]:prefix:' \
    '--parallel[Maximum number of child boots in flight during a batch branch (default 4)]:count:' \
    '--wait-ready[Wait for smolvm-branch-ready in a single-child branch (batch branches always wait)]' \
    '--hold[Keep each child parked at the inherited branch point as an already-booted pool slot]' \
    '--ready-timeout[Maximum time to wait for the source workload branch boundary (default 10m)]:duration:' \
    '--wait-worker-ready[Count a batch child as branched only once its workload has run smolvm-worker-ready]' \
    '--worker-ready-timeout[Window for --wait-worker-ready (default 5m)]:duration:' \
    '--branchable[Make the child itself branchable (memfd RAM + control socket)]' \
    '--share-weights[Share the source CUDA weights with this child instead of copying them]' \
    '*'{-e,--env}'[Per-branch parameter, delivered as smolvm-branch-ready env (repeatable)]:KEY=VALUE:' \
    '*'{-p,--port}'[Pin the child inbound port forwards (repeatable); otherwise remapped to free ports]:HOST[-END]\:GUEST[-END]:' \
    '*--secret-env[Inject a per-branch secret from a host env var (repeatable)]:GUEST_VAR=HOST_VAR:_smolvm_secret_env' \
    '*--secret-file[Inject a per-branch secret from a host file (repeatable)]:GUEST_VAR=/abs/path:_smolvm_secret_file'
}

_smolvm_machine_checkpoint() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Running machine to checkpoint]:machine:_smolvm_machine_names' \
    '(-o --output)'{-o,--output}'[Destination .smolcheckpoint file]:file:_files' \
    '--staging-dir[Directory under which large temporary checkpoint assets are staged]:dir:_files -/' \
    '--proxy[Proxy URL used for the in-VM image pull]:URL:' \
    '--no-proxy[Comma-separated NO_PROXY list that bypasses the proxy during image pull]:list:'
}

_smolvm_machine_branch_release() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Held child to assign and release]:machine:_smolvm_machine_names' \
    '*'{-e,--env}'[Assignment parameter, overrides values set at provisioning (repeatable)]:KEY=VALUE:' \
    '--wait-worker-ready[Report the slot as released only once its workload has run smolvm-worker-ready]' \
    '--worker-ready-timeout[Window for --wait-worker-ready (default 5m)]:duration:'
}

_smolvm_machine_stop() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to stop (default: "default")]:machine:_smolvm_machine_names'
}

_smolvm_machine_delete() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to delete]:machine:_smolvm_machine_names' \
    '(-f --force)'{-f,--force}'[Skip confirmation prompt]' \
    '--cascade[Also delete children branched from this machine (children before the base)]'
}

_smolvm_machine_status() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to check (default: "default")]:machine:_smolvm_machine_names' \
    '--json[Output in JSON format]'
}

_smolvm_machine_egress_events() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to inspect (default: "default")]:machine:_smolvm_machine_names' \
    '--limit[Maximum number of events to show (newest kept, default 200)]:N:' \
    '--json[Output in JSON format]'
}

_smolvm_machine_ls() {
  _arguments \
    $_smolvm_help_opt \
    '(-v --verbose)'{-v,--verbose}'[Show detailed configuration (mounts, ports, PID)]' \
    '--json[Output in JSON format]' \
    '(-q --quiet)'{-q,--quiet}'[Print only machine names, one per line]'
}

_smolvm_machine_update() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to update]:machine:_smolvm_machine_names' \
    '*'{-v,--volume}'[Add volume mount (repeatable)]:HOST\:GUEST[\:ro|rw|staged]:_files -/' \
    '--allow-system-mounts[Allow adding trusted read-only host /etc and /var/log mounts below /host]' \
    '*--remove-volume[Remove volume mount]:HOST\:GUEST:' \
    '*'{-p,--port}'[Add port mapping or one-to-one range (repeatable)]:HOST[-END]\:GUEST[-END]:' \
    '*--remove-port[Remove port mapping or one-to-one range]:HOST[-END]\:GUEST[-END]:' \
    '--cpus[Set vCPU count]:N:' \
    '--mem[Set memory in MiB]:MiB:' \
    '(--no-net)--net[Enable outbound network access]' \
    '(--net)--no-net[Disable outbound network access]' \
    '*'{-e,--env}'[Add/replace environment variable (repeatable)]:KEY=VALUE:' \
    '*--remove-env[Remove environment variable by key]:KEY:' \
    '(-w --workdir)'{-w,--workdir}'[Set working directory]:dir:_files -/' \
    '(--no-gpu)--gpu[Enable GPU acceleration]' \
    '(--gpu)--no-gpu[Disable GPU acceleration]' \
    '(--no-rosetta)--rosetta[Enable Rosetta 2 for x86_64 binary translation]' \
    '(--rosetta)--no-rosetta[Disable Rosetta 2]' \
    '--storage[Storage disk size in GiB (expand only)]:GiB:' \
    '--overlay[Overlay disk size in GiB (expand only)]:GiB:' \
    '--block-io[Set the host block I/O engine for the next start]:engine:_smolvm_block_io'
}

_smolvm_machine_images() {
  _arguments \
    $_smolvm_help_opt \
    '--name[Machine to query]:machine:_smolvm_machine_names' \
    '--json[Output in JSON format]'
}

_smolvm_machine_prune() {
  _arguments \
    $_smolvm_help_opt \
    '--name[Machine to prune]:machine:_smolvm_machine_names' \
    '--dry-run[Show what would be removed without actually removing]' \
    '--all[Remove all cached images, not just unreferenced layers (requires the machine stopped)]'
}

_smolvm_machine_shell() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Target machine (default: "default")]:machine:_smolvm_machine_names'
}

_smolvm_machine_cp() {
  _arguments \
    $_smolvm_help_opt \
    '--mode[Set the file'\''s mode on upload (octal, e.g. 644)]:octal:' \
    '--uid[Set the file'\''s owner uid on upload]:uid:' \
    '--gid[Set the file'\''s owner gid on upload]:gid:' \
    '1:source (local file or machine\:path):_smolvm_cp_path' \
    '2:destination (local file or machine\:path):_smolvm_cp_path'
}

_smolvm_machine_sync() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to synchronize (default: "default")]:machine:_smolvm_machine_names'
}

_smolvm_machine_monitor() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine to monitor (default: "default")]:machine:_smolvm_machine_names' \
    '--restart[Override restart policy]:policy:(never always on-failure unless-stopped)' \
    '--health-cmd[Health check command (run inside the VM via sh -c)]:command:' \
    '--health-timeout[Health check timeout in seconds (default 5)]:seconds:' \
    '--interval[Check interval in seconds (default 5)]:seconds:' \
    '--health-retries[Health check failures before triggering restart (default 3)]:N:'
}

_smolvm_machine_data_dir() {
  _arguments \
    $_smolvm_help_opt \
    '(-n --name)'{-n,--name}'[Machine name]:machine:_smolvm_machine_names'
}

# --- serve -----------------------------------------------------------------

_smolvm_serve_start() {
  _arguments \
    $_smolvm_help_opt \
    '(-l --listen)'{-l,--listen}'[Address and port or Unix socket path to listen on]:address:(unix\:///tmp/smolvm.sock 127.0.0.1\:8080)' \
    '(-v --verbose)'{-v,--verbose}'[Enable debug logging (or set RUST_LOG=debug)]' \
    '*--cors-origin[CORS allowed origin (repeatable); defaults to localhost\:8080 and localhost\:3000]:origin:' \
    '--json-logs[Output logs as structured JSON (for log aggregators)]' \
    '--seccomp[Seccomp syscall-allowlist mode for VM boot subprocesses (x86_64-Linux only)]:mode:(enforce audit off)' \
    '--landlock[Landlock filesystem-confinement mode for VM boot subprocesses (Linux only)]:mode:(enforce off)'
}

_smolvm_serve_openapi() {
  _arguments \
    $_smolvm_help_opt \
    '(-o --output)'{-o,--output}'[Output file path (defaults to stdout)]:file:_files' \
    '(-f --format)'{-f,--format}'[Output format]:format:(json yaml)'
}

# --- pack ------------------------------------------------------------------

_smolvm_pack_create() {
  _arguments \
    $_smolvm_help_opt \
    '(--from-vm -I --image)'{-I,--image}'[Container image to pack (e.g. alpine:latest, python:3.11-slim)]:image:_files' \
    '(-I --image)--from-vm[Pack from a stopped VM snapshot instead of an OCI image]:machine:_smolvm_machine_names' \
    '--rebase-from-image[Rebuild lower layers from vm.image instead of preserving imported artifact layers]' \
    '--include-workspace[Also capture the machine /workspace so a machine made from the pack starts with those files]' \
    '(-o --output)'{-o,--output}'[Output file path for the packed binary]:file:_files' \
    '--cpus[Maximum vCPUs machines from this pack may use (default 4)]:N:' \
    '--mem[Maximum memory in MiB machines from this pack may use (default 8192)]:MiB:' \
    '--oci-platform[Target OCI platform for multi-arch images (default: host architecture)]:platform:(linux/arm64 linux/amd64)' \
    '--entrypoint[Override the image entrypoint]:command:' \
    '--no-sign[Skip code signing (macOS only)]' \
    '--single-file[Pack as a single file (no .smolmachine sidecar)]' \
    '(-s --smolfile)'{-s,--smolfile}'[Load workload configuration from a Smolfile (TOML)]:Smolfile:_smolvm_smolfile' \
    '--gpu[Enable GPU acceleration (Vulkan via virtio-gpu) in the packed VM]' \
    '--staging-dir[Directory under which to stage pack assets]:dir:_files -/' \
    '--proxy[Proxy URL used for the in-VM image pull]:URL:' \
    '--no-proxy[Comma-separated NO_PROXY list that bypasses the proxy during image pull]:list:'
}

_smolvm_pack_run() {
  local context state line
  typeset -A opt_args

  _arguments \
    $_smolvm_help_opt \
    '--sidecar[Path to the .smolmachine sidecar file]:file:_smolvm_smolmachine' \
    '--force-extract[Re-extract assets even if already cached]' \
    '--info[Show manifest info and exit]' \
    '--debug[Enable debug output]' \
    '--cuda[Enable CUDA-over-vsock (also automatic when the pack was created with CUDA)]' \
    '--auto-graph[Ask compatible CUDA frameworks to graph safe compiled regions (implies --cuda)]' \
    '(-i --interactive)'{-i,--interactive}'[Keep stdin open for interactive input]' \
    '(-t --tty)'{-t,--tty}'[Allocate a pseudo-TTY (use with -i for interactive shells)]' \
    '--timeout[Kill command after duration]:duration:(30s 5m 1h)' \
    '(-w --workdir)'{-w,--workdir}'[Set working directory inside container]:dir:_files -/' \
    '(-u --user)'{-u,--user}'[Run as this user (a name or uid:gid)]:user:' \
    '*'{-e,--env}'[Set environment variable (repeatable)]:KEY=VALUE:' \
    '*'{-v,--volume}'[Mount host directory into container (repeatable)]:HOST\:CONTAINER[\:ro]:_files -/' \
    '--allow-system-mounts[Allow trusted read-only host /etc and /var/log mounts below /host]' \
    '*'{-p,--port}'[Expose port from container to host (repeatable)]:HOST\:GUEST:' \
    '--net[Enable outbound network access]' \
    '--net-backend[Select the networking backend]:backend:((tsi\:"Use libkrun TSI networking" virtio-net\:"Use virtio-net with the host-side smolvm network stack"))' \
    '--cpus[Number of virtual CPUs (overrides manifest default)]:N:' \
    '--mem[Memory allocation in MiB (overrides manifest default)]:MiB:' \
    '--storage[Storage disk size in GiB (for OCI layers and container data)]:GiB:' \
    '--overlay[Overlay disk size in GiB (for persistent rootfs changes)]:GiB:' \
    '--block-io[Block I/O engine]:engine:_smolvm_block_io' \
    '*:: :->command' && return 0

  if [[ $state == command ]]; then
    # `_arguments` keeps a literal `--` options terminator inside the
    # sub-command slice; drop it so _normal sees the guest command first.
    if [[ $words[1] == -- ]]; then
      shift words
      (( CURRENT > 1 )) && (( CURRENT-- ))
    fi
    _normal
    return
  fi
  return 1
}

_smolvm_pack_push() {
  _arguments \
    $_smolvm_help_opt \
    '(-f --file)'{-f,--file}'[Path to the .smolmachine file to push]:file:_smolvm_smolmachine' \
    '1:artifact reference:_smolvm_artifact_ref'
}

_smolvm_pack_pull() {
  _arguments \
    $_smolvm_help_opt \
    '(-o --output)'{-o,--output}'[Output path for the downloaded .smolmachine file]:file:_files' \
    '1:artifact reference:_smolvm_artifact_ref'
}

_smolvm_pack_inspect() {
  _arguments \
    $_smolvm_help_opt \
    '--json[Output as JSON]' \
    '1:artifact reference:_smolvm_artifact_ref'
}

_smolvm_pack_prune() {
  _arguments \
    $_smolvm_help_opt \
    '--keep[Number of unused cached entries to keep (default 5)]:N:' \
    '--all[Remove all unused cached entries (machine references are always retained)]' \
    '--dry-run[Show what would be removed without actually removing]'
}

# --- registration ------------------------------------------------------------

# compinit already ran (sourced interactively or via a plugin manager):
# register directly. When autoloaded from fpath as `_smolvm` (or `_smolvm.zsh`),
# the file itself is executed as the function body, so call through.
(( $+functions[compdef] )) && compdef _smolvm smolvm
if [[ "$funcstack[1]" == _smolvm(|.zsh) ]]; then
  _smolvm "$@"
fi
