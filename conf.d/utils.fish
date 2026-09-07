# These utilities are only for interactive mode.
if not status is-interactive && test "$CI" != true
    exit
end

set --global __utils_version 1.0.0
set --global __utils_format_version 1.0.0
set --global __utils_backup_version 1.0.0

abbr --add !! --position anywhere --function last_history_item

abbr --add j journalctl
abbr --add jf 'journalctl --no-hostname --no-full --quiet --pager-end --follow\
  --exclude-identifier="uwsm_hyprland.desktop"'

abbr --add s systemctl
abbr --command systemctl u -- --user
abbr --command systemctl r -- --restart
abbr --command systemctl e -- --enable
abbr --command systemctl n -- --now

abbr --add nv nvim
abbr --add lazyvim 'NVIM_APPNAME=lvim nvim' # The default lazyvim experience.
abbr --add lvim lazyvim
abbr --add lv lvim
abbr --add nevim 'NVIM_APPNAME=nevim nvim' # My attempt to use default package manager.
abbr --add nev nevim

abbr --add ld lazydocker
abbr --add lg lazygit

abbr --add py python

abbr --add b --position anywhere '| bat'
abbr --add l --position anywhere '| less'
abbr --add L --position anywhere --set-cursor '% | less'

abbr --add rg --position anywhere '| rg'
abbr --add !rg --position anywhere '| rg -line-buffered -v'
abbr --add Rg --position anywhere --set-cursor "| rg '%'"
abbr --add !Rg --position anywhere --set-cursor "| rg --line-buffered -v '%'"

function _utils_uninstall --on-event utils_uninstall
    set --erase __utils_version
    set --erase __utils_backup_version
    set --erase __utils_format_version

    abbr --erase !!

    abbr --erase j
    abbr --erase jf

    abbr --erase s
    abbr --command systemctl --erase u
    abbr --command systemctl --erase r
    abbr --command systemctl --erase e
    abbr --command systemctl --erase n

    abbr --erase nvim
    abbr --erase lazyvim
    abbr --erase lvim
    abbr --erase lv
    abbr --erase nevim
    abbr --erase nev

    abbr --erase ld
    abbr --erase lg

    abbr --erase py

    abbr --erase b
    abbr --erase l
    abbr --erase L

    abbr --erase rg
    abbr --erase !rg
    abbr --erase Rg
    abbr --erase !Rg

    functions --erase backup
    functions --erase format
    functions --erase last_history_item
    functions --erase log
    functions --erase mkcd
    functions --erase user_confirm

    complete --erase backup
    complete --erase format

    emit git_abbr_uninstall
    emit datetime_abbr_uninstall
end
