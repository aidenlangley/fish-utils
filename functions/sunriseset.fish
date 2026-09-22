function _fetch --description 'Get sunrise and sunset from API' --argument-names lat lng
    set BASE_URL 'https://api.sunrise-sunset.org/v2'
    set req "$BASE_URL?lat=$lat&lng=$lng"
    set resp (curl -s $req)

    set data (echo $resp | jq '.sunrise,.sunset' | string replace --all '"' '')

    set sunrise (string sub --start=12 --end=16 $data[1])
    set sunset (string sub --start=12 --end=16 $data[2])

    echo $sunrise $sunset
end

function sunriseset --description 'Get sunrise and sunset from api.sunrise-sunset.org'
    set __name (string split '.' (basename (status -f)))[1]
    set __version '0.1.0'
    set __description 'Get sunrise and sunset from api.sunrise-sunset.org'

    set opts (fish_opt --short h --long help)
    set opts $opts (fish_opt --short t --long latitude)
    set opts $opts (fish_opt --short g --long longitude)

    argparse $opts -- $argv

    # Print help.
    if set --query _flag_h || not argparse --min-args=1 -- $argv &>/dev/null
    end

    # Check if we have been given -t/--latitude & -g/-longitude
    if not set --query _flag_t || not set --query _flag_g

        # No latitude/longitude - check $XDG_CONFIG_HOME.
        set config_file "$XDG_CONFIG_HOME/sunriseset/config"
        if not test -e $config_file

            # No dice, check $HOME for a config file.
            set config_file "$HOME/.sunriseset"
            if not test -e $config_file

                # No config, no go.
                log --level ERR 'Config not found, need -t/--latitude and -g/--longitude'
                exit 1
            end
        end

        set config (cat $config_file)
        set _flag_t $config[1]
        set _flag_g $config[2]

        if not set --query _flag_t
            log --level ERR 'Missing -t/--latitude'
            exit 1
        end

        if not set --query _flag_g
            log --level ERR 'Missing -g/--longitude'
            exit 1
        end
    end

    set lat $_flag_t
    set lng $_flag_g

    if not _is_number $lat
        log --level ERR "$lat is not a number/float"
        exit 1
    end

    if not _is_number $lng
        log --level ERR "$lng is not a number/float"
        exit 1
    end

    set cache_file "$XDG_CACHE_HOME/sunriseset"

    if test -e $cache_file
        set data (cat $cache_file)

        if test (stat -c "%Y" $cache_file) -gt 86400
            # If cache is more than a day old, get fresh data + overwrite the cache.
            set data (_fetch $lat $lng)
            echo $data >$cache_file
        end
    else
        # No cache, we need fresh data, and we can cache it.
        set data (_fetch $lat $lng)
        echo $data >$cache_file
    end

    set sunrise $data[1]
    set sunset $data[2]

    echo "$sunrise $sunset"
    exit 0
end
