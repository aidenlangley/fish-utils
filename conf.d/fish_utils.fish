# These utilities are only for interactive mode.
if not status is-interactive && test "$CI" != true
    exit
end

set --global __fish_utils_version '0.2.0'

function _utils_uninstall --on-event utils_uninstall
    set --erase __fish_utils_version
end
