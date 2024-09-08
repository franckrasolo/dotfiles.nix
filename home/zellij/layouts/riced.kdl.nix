{ pkgs }:

''
layout {
  default_tab_template {
    children
    pane size=1 {
      plugin location="file:${pkgs.zjstatus}/bin/zjstatus.wasm" {
        color_bg      "#0b2d4f"
        color_black   "#071222"
        color_fg      "#b4bebe"
        color_white   "#596666"
        color_magenta "#f4d2e5"
        color_red     "#e43460"
        color_orange  "#dbc074"
        color_yellow  "#f1e09d"
        color_green   "#71d5b0"
        color_cyan    "#73d4d6"
        color_blue    "#719cd6"

        format_left   "{mode}#[bg=$black] {tabs}"
        format_center ""
        format_right  "{swap_layout} #[bg=$black,fg=$yellow]#[bg=$yellow,fg=$bg,bold]󰽙#[bg=$yellow,fg=$bg,bold,italic] {session} "
        format_space  "#[bg=$black]"
        format_hide_on_overlength "false"
        format_precedence "crl"

        border_enabled  "false"
        border_char     "─"
        border_format   "#[fg=$yellow]{char}"
        border_position "top"

        swap_layout_format "#[bg=$black,fg=$green]#[bg=$green,fg=$bg,bold]{name}#[bg=$black,fg=$green]"
        swap_layout_hide_if_empty "true"

        hide_frame_for_single_pane "false"

        mode_normal       "#[bg=$bg,fg=$green,bold] 󰫈 NORMAL#[bg=$black,fg=$bg]"
        mode_locked       "#[bg=$red,fg=$bg,bold] 󰫈 LOCKED #[bg=$black,fg=$red]"
        mode_resize       "#[bg=$orange,fg=$bg,bold] 󰫈 RESIZE#[bg=$black,fg=$orange]"
        mode_pane         "#[bg=$green,fg=$bg,bold] 󰫈 PANE#[bg=$black,fg=$green]"
        mode_tab          "#[bg=$yellow,fg=$bg,bold] 󰫈 TAB#[bg=$black,fg=$yellow]"
        mode_scroll       "#[bg=$magenta,fg=$bg,bold] 󰫈 SCROLL#[bg=$black,fg=$magenta]"
        mode_enter_search "#[bg=$orange,fg=$bg,bold] 󰫈 ENTER SEARCH#[bg=$black,fg=$orange]"
        mode_search       "#[bg=$orange,fg=$bg,bold] 󰫈 SEARCH#[bg=$black,fg=$orange]"
        mode_rename_tab   "#[bg=$orange,fg=$bg,bold] 󰫈 RENAME TAB#[bg=$black,fg=$orange]"
        mode_rename_pane  "#[bg=$cyan,fg=$bg,bold] 󰫈 RENAME PANE#[bg=$black,fg=$cyan]"
        mode_session      "#[bg=$orange,fg=$bg,bold] 󰫈 SESSION#[bg=$black,fg=$orange]"
        mode_move         "#[bg=$yellow,fg=$bg,bold] 󰫈 MOVE#[bg=$black,fg=$yellow]"
        mode_prompt       "#[bg=$fg,fg=$bg,bold] 󰫈 PROMPT#[bg=$black,fg=$fg]"
        mode_tmux         "#[bg=$cyan,fg=$bg,bold] 󰫈 TMUX#[bg=$black,fg=$cyan]"

        // formatting for inactive tabs
        tab_normal            "#[bg=$black,fg=$white]#[bg=$white,fg=$magenta,italic]{index} #[bg=$fg,fg=$white,italic] {name}{floating_indicator} #[bg=$black,fg=$fg,bold]"
        tab_normal_fullscreen "#[bg=$black,fg=$white]#[bg=$white,fg=$magenta,italic]{index} #[bg=$fg,fg=$white,italic] {name}{fullscreen_indicator} #[bg=$black,fg=$fg,bold]"
        tab_normal_sync       "#[bg=$black,fg=$white]#[bg=$white,fg=$magenta,italic]{index} #[bg=$fg,fg=$white,italic] {name}{sync_indicator} #[bg=$black,fg=$fg,bold]"

        // formatting for the current active tab
        tab_active            "#[bg=$black,fg=$green]#[bg=$green,fg=$bg,bold]{index} #[bg=$bg,fg=$green,bold] {name}{floating_indicator} #[bg=$black,fg=$bg,bold]"
        tab_active_fullscreen "#[bg=$black,fg=$green]#[bg=$green,fg=$bg,bold]{index} #[bg=$bg,fg=$green,bold] {name}{fullscreen_indicator} #[bg=$black,fg=$bg,bold]"
        tab_active_sync       "#[bg=$black,fg=$green]#[bg=$green,fg=$bg,bold]{index} #[bg=$bg,fg=$green,bold] {name}{sync_indicator} #[bg=$black,fg=$bg,bold]"

        // separator between the tabs
        tab_separator         "#[bg=$black] "

        // indicators
        tab_sync_indicator       " "
        tab_fullscreen_indicator " 󰊓"
        tab_floating_indicator   " 󰹙"

        command_git_branch_command    "git rev-parse --abbrev-ref HEAD"
        command_git_branch_format     "#[fg=$blue] {stdout} "
        command_git_branch_interval   "10"
        command_git_branch_rendermode "static"

        datetime          "#[fg=$fg,bold] {format} "
        datetime_format   "%a %d %b %Y %H:%M:%S"
        datetime_timezone "Europe/London"
      }
    }
  }
}
''
