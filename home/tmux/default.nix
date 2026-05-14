{ config, pkgs, user, ... }:

let
  resolve_command = { fallback ? ", #W" } : ''
     #{?#{==:#{pane_current_command},zsh}, #W
    ,#{?#{==:#{pane_current_command},nvim}, #W
    ,#{?#{==:#{pane_current_command},git}, #W
    ,#{?#{==:#{pane_current_command},lazygit}, #W
    ,#{?#{==:#{pane_current_command},devenv},󱄅 #W
    ,#{?#{==:#{pane_current_command},mise},󰭼 #W
    ,#{?#{==:#{pane_current_command},nix},󱄅 #W
    ,#{?#{==:#{pane_current_command},btm},󱒉 #W
    ,#{?#{==:#{pane_current_command},htop},󰝪 #W
    ,#{?#{==:#{pane_current_command},fd},󰱼 #W
    ,#{?#{==:#{pane_current_command},rg},󰱼 #W
    ,#{?#{==:#{pane_current_command},time},󰄉 #W
    ,#{?#{==:#{pane_current_command},watch}, #W
    ,#{?#{==:#{pane_current_command},yazi},󰇥 #W
    ,#{?#{==:#{pane_current_command},opencode}, #W
    ,#{?#{==:#{pane_current_command},tmux},󰕴 #W
    ,#{?#{==:#{pane_current_command},tv},󱧻 #W
    ,#{?#{==:#{pane_current_command},workmux},󰵼 #W
    ,#{?#{==:#{pane_current_command},zellij},󰫈 #W
    ,#{?#{==:#{pane_current_command},cdktn},󱁢 #W
    ,#{?#{==:#{pane_current_command},formae}, #W
    ,#{?#{==:#{pane_current_command},pulumi}, #W
    ,#{?#{==:#{pane_current_command},terraform},󱁢 #W
    ,#{?#{==:#{pane_current_command},aws},󰸏 #W
    ,#{?#{==:#{pane_current_command},taws},󰸏 #W
    ,#{?#{==:#{pane_current_command},gcloud},󱇶 #W
    ,#{?#{==:#{pane_current_command},tgcp},󱇶 #W
    ,#{?#{==:#{pane_current_command},docker}, #W
    ,#{?#{==:#{pane_current_command},lazydocker}, #W
    ,#{?#{==:#{pane_current_command},helm},󱃾 #W
    ,#{?#{==:#{pane_current_command},kubectl},󱃾 #W
    ,#{?#{==:#{pane_current_command},k9s},󱃾 #W
    ,#{?#{==:#{pane_current_command},cabal}, #W
    ,#{?#{==:#{pane_current_command},hoogle}, #W
    ,#{?#{==:#{pane_current_command},stack}, #W
    ,#{?#{==:#{pane_current_command},cargo}, #W
    ,#{?#{==:#{pane_current_command},go}, #W
    ,#{?#{==:#{pane_current_command},python}, #W
    ,#{?#{==:#{pane_current_command},uv}, #W
    ,#{?#{==:#{pane_current_command},gradle}, #W
    ,#{?#{==:#{pane_current_command},java},󰬷 #W
    ,#{?#{==:#{pane_current_command},kotlin},󱈙 #W
    ${fallback}
    }}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
  '';
  accent_colour = "#{?client_prefix,#{E:@thm_maroon},#{E:@thm_yellow}}";
  tmux_config_dir = "${config.xdg.configHome}/tmux";
  zoom_decoration = "#{?window_zoomed_flag, 󱡴 ,}";
in
with pkgs.unstable;
{
  programs.tmux = {
    enable = true;
    package = tmux;
    aggressiveResize = true;
    baseIndex = 1;
    clock24 = true;
    disableConfirmationPrompt = true;
    escapeTime = 0;
    focusEvents = true;
    historyLimit = 100000;
    keyMode = "vi";
    mouse = false;
    newSession = false;
    resizeAmount = 15;
    secureSocket = false;
    sensibleOnTop = true;
    terminal = "tmux-256color";

    plugins = with tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"

          set -g @catppuccin_window_number_position "left"
          set -g @catppuccin_window_status_style "rounded"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_number_color "${accent_colour}"
          set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
          set -g @catppuccin_window_current_text "${resolve_command {}}${zoom_decoration}"

          set -g @catppuccin_window_fill "number"
          set -g @catppuccin_window_number_color "#{@thm_surface_2}"
          set -g @catppuccin_window_text_color "#{@thm_mantle}"
          set -g @catppuccin_window_text \
            "${resolve_command { fallback = ",#{?#{==:#W,#{host}}, N/A, #W}"; }}${zoom_decoration}"

          set -g @catppuccin_status_background "black"
          set -g @catppuccin_status_left_separator ""
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_session_icon "󰕴 "
          set -g @catppuccin_session_color "${accent_colour}"

          set -g @catppuccin_date_time_icon "󱑂 "
          set -g @catppuccin_date_time_color "${accent_colour}"
          set -g @catppuccin_date_time_text " %H:%M:%S %Z" # date: %a %d %b %Y"
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '10' # minutes
        '';
      }
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      tmux-fzf
      {
        plugin = fzf-tmux-url;
        extraConfig = ''
          set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
          set -g @fzf-url-history-limit '500'
        '';
      }
      yank
    ];

    extraConfig = ''
      set -g status-position top
      set -g status-justify centre

      source-file ${tmux_config_dir}/tmux.local.conf

      # add TrueColor support
      set -ag terminal-overrides ",xterm-256color:Ms=\\E]52;c;%p2%s\\7,Referer:Tc"

      set -g detach-on-destroy off  # don't exit from tmux when closing a session
      set -g display-time 750       # restore the original 750ms duration
      set -sg escape-time 100       # ~5-100ms. https://superuser.com/a/1809494 explains why
      set -g renumber-windows on    # renumber all windows when any window is closed
      set -g set-clipboard on       # use system clipboard

      set -g status-left "#{E:@catppuccin_status_session}"
      set -g status-right "#{E:@catppuccin_status_date_time}"

      set -g display-panes-active-colour "#f9e2af"
      set -g display-panes-colour "#6c7086"
      set -g message-style fg="#{E:@thm_green}",bg=default,bold,italics
      set -g pane-active-border-style 'fg=#{@thm_yellow},bg=default'
      set -g pane-border-style 'fg=#{@thm_surface_0},bg=default'

      setw -g clock-mode-colour "#f9e2af"
      setw -g clock-mode-style "24-with-seconds"

      set -g popup-style "bg=#110C1E,fg=#{@thm_fg}"
      set -g popup-border-style "bg=#110C1E,fg=#7D5A9A"
      set -g popup-border-lines "rounded"

      bind r source-file ${tmux_config_dir}/tmux.conf \; display-message "> tmux config reloaded!"
    '';
  };

  programs.fzf.tmux.enableShellIntegration = true;

  programs.sesh = {
    enable = true;
    enableAlias = false;
    enableTmuxIntegration = false;
    icons = true;
    package = sesh;
    fzfPackage = fzf;
    zoxidePackage = zoxide;
  };

  home.packages = [
    tmuxinator
  ];

  xdg.configFile."sesh/sesh.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/tmux/sesh.toml";

  xdg.configFile."tmux/tmux.local.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/tmux/tmux.local.conf";

  programs.zsh.shellAliases = {
    ta = "tmux attach -t";
    tl = "tmux list-sessions";
    ts = "tmux new-session -s";
    tkss = "tmux kill-session -t";
    tksv = "tmux kill-server";
  };
}
