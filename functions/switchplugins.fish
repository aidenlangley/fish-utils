if not functions -q fisher
    exit
end

function switchplugins --description 'Swap our remote plugins for local plugins\
  for testing, and vice versa.'
    for plugin in (fisher list)
        set plugin_name (string split '/' $plugin)[-1]
        set remote_plugin "aidenlangley/$plugin_name"
        set local_plugin "$HOME/Projects/fish/$plugin_name"

        # We're only interested in plugins we can test locally, so they must
        # exist @ $local_plugin.
        if test -e $local_plugin
            function _install_local --description "Remove remote plugins, install local plugins"
                fisher remove $remote_plugin &>/dev/null
                fisher install $local_plugin &>/dev/null
                log -l OK "Installed $local_plugin"
            end

            function _install_remote --description "Remove local plugins, install remote plugins"
                fisher remove $local_plugin &>/dev/null
                fisher install $remote_plugin &>/dev/null
                log -l OK "Installed $remote_plugin"
            end

            switch $argv
                case local
                    _install_local
                case remote
                    _install_remote
                case *
                    if string match aidenlangley $plugin
                        _install_local
                    else
                        _install_remote
                    end
            end
        end
    end
end
