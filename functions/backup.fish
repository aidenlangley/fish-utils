function backup --description 'Quickly create backups of files & directories'
    set __name (string split '.' (basename (status -f)))[1]
    set __version $__utils_backup_version
    set __description 'Quickly create backups of files & directories'

    set opts (fish_opt --short h --long help)
    set opts $opts (fish_opt --short v --long version)
    # Flags
    set opts $opts (fish_opt --short a --long append --optional-val)
    set opts $opts (fish_opt --short g --long debug)
    set opts $opts (fish_opt --short i --long interactive)
    set opts $opts (fish_opt --short q --long quiet)
    set opts $opts (fish_opt --short V --long verbose)
    # Args.
    set opts $opts (fish_opt --short d --long dest --required-val)
    set opts $opts (fish_opt --short D --long mkdir --required-val)
    set opts $opts (fish_opt --short e --long ext --required-val)
    set opts $opts (fish_opt --short f --long format_datetime --required-val)
    set opts $opts (fish_opt --short s --long suffix --required-val)
    set opts $opts (fish_opt --short S --long swap --required-val)

    argparse $opts -- $argv

    if set --query _flag_h || not argparse --min-args=1 -- $argv &>/dev/null
        set TAB '  '
        set FLAG_DELIM ', '

        set name (set_color --bold green)$__name(set_color --reset)
        set desc (set_color --italic)$__description(set_color --reset)
        echo (printf '%s %s - %s.' $name $__version $desc)

        function _usage --inherit-variable __name --argument-names args
            echo (set_color --bold cyan)$__name(set_color --reset) $args
        end

        function _desc --argument-names desc
            echo (set_color --dim brwhite)$desc(set_color --reset)
        end

        function _option --argument-names args
            echo (set_color --bold cyan)$args(set_color --reset)
        end

        echo
        echo (set_color --bold green)'Usage:'(set_color --reset)
        echo $TAB(_usage '[OPTIONS] [ARGS]...')
        echo $TAB(_usage '-f/--format_datetime -%s [ARGS]...')
        echo $TAB$TAB (_desc 'Format the datetime to your liking.')
        echo $TAB(_usage '-D/--mkdir archive -a [ARGS]...')
        echo $TAB$TAB (_desc 'Specify a backup directory with -d/--dest, have it created automatically with -D/--makedir.')
        echo $TAB(_usage '-s/--suffix '(printf "%s.bak" (date +'%Y-%m-%d'))' [ARGS]...')
        echo $TAB$TAB (_desc 'Completely replace the suffix, datetime and file extension with one option.')

        echo
        echo (set_color --bold green)'Options:'(set_color --reset)
        echo $TAB(_option (string join -- $FLAG_DELIM -a --append)' <FORMAT>')
        echo $TAB$TAB'Append todays date to the target backup directory.'
        echo $TAB(_option (string join -- $FLAG_DELIM -d --dest)' <DIRECTORY>')
        echo $TAB$TAB'Backup FILES to this DESTINATION.'
        echo $TAB(_option (string join -- $FLAG_DELIM -D --mkdir)' <DIRECTORY>')
        echo $TAB$TAB"Backup FILES to this DESTINATION, and make the directory if it doesn't exist."
        echo $TAB(_option (string join -- $FLAG_DELIM -e --ext)' <FILE_EXTENSION>')
        echo $TAB$TAB'File extension. Default: bak.'
        echo $TAB(_option (string join -- $FLAG_DELIM -f --format_datetime)' <FORMAT>')
        echo $TAB$TAB"Date time format to use in the backup file name. Default: $default_datetime_format."
        echo $TAB(_option (string join -- $FLAG_DELIM --debug))
        echo $TAB$TAB'Debug output, very verbose.'
        echo $TAB(_option (string join -- $FLAG_DELIM -i --interactive))
        echo $TAB$TAB'Confirm each operation in interactive mode.'
        echo $TAB(_option (string join -- $FLAG_DELIM -s --suffix)' <STRING>')
        echo $TAB$TAB'Backup file suffix (datetime + extension).'
        echo $TAB(_option (string join -- $FLAG_DELIM -S --swap)' <DIRECTORY>')
        echo $TAB$TAB'Leave the backup in place, but move the original to DESTINATION.'
        echo $TAB(_option (string join -- $FLAG_DELIM -v --version))
        echo $TAB$TAB'Print name & version.'
        echo $TAB(_option (string join -- $FLAG_DELIM -V --verbose))
        echo $TAB$TAB'Verbose output.'

        return
    end

    # Runtime flags
    set --query _flag_g && set debug $_flag_g
    set --query debug && set --show _flag_a _flag_d _flag_D _flag_e \
        _flag_i _flag_f _flag_s _flag_S _flag_v _flag_V

    set --query _flag_i && set interactive $_flag_i
    set --query _flag_V && set verbose $_flag_V
    set --query _flag_q && set quiet $_flag_q
    set --query debug && set --show debug interactive verbose quiet

    # Defaults
    set default_datetime_format '_%Y%m%d_%H:%M:%S.%N'
    set default_ext bak

    # Set users datetime_format or default.
    set --query _flag_f && set datetime_format $_flag_f \
        || set datetime_format $default_datetime_format

    # Set users extension or default.
    set --query _flag_e && set ext $_flag_e \
        || set ext $default_ext

    set --query debug && set --show datetime_format ext

    for arg in $argv

        if set --query verbose && set --query interactive
            log --timestamp --level INF (set_color -o)'-i/--interactive'(set_color --reset)' is set, file operations will require confirmation'
        end

        if set --query verbose
            log --timestamp --level INF "Beginning backup of" (set_color -o yellow)$arg(set_color --reset)
        end

        # Test if $arg is a FILE or DIRECTORY - this is what we're backing up, so it 
        # must exist.
        if not test -e $arg
            log --timestamp --level ERR "$arg does not exist"
            notify-send "Backup $arg" $msg[2] -c "transfer.error"
            return 1
        end

        if set --query verbose
            log --timestamp --level INF 'Found '(set_color -o yellow)$arg(set_color --reset)', backup can proceed'
        end

        # If user has specified -d/--dest, or -D/--mkdir, we'll take the final part of $arg (the path),
        # and append it to the path provided by the user. -D/--mkdir takes priority. Both options provide
        # a destination directory, but -D/--mkdir gives us permission to create the directory also, so 
        # we don't want to check them both. We want to action -D/--mkdir first.
        if set --query _flag_D
            set mkdir $_flag_D
            set dest $_flag_D
            set --query verbose && log --timestamp --level INF (set_color -o)' -D/--mkdir'(set_color --reset)
        else if set -qf _flag_d
            set dest $_flag_d
            set --query verbose && log --timestamp --level INF (set_color -o)' -d/--dest'(set_color --reset)
        end
        set --query debug && set --show dest

        if set --query verbose && set --query dest
            log --timestamp --level INF "-d/--dest is set, so we'll archive "(set_color -o yellow)$arg(set_color --reset)' to '(set_color -o)"$dest/"(set_color --reset)
        end

        # If we're interactive and haven't defined dest, we'll ask the user if they want the default,
        # or another backup directory.
        if set --query interactive && not set --query dest
            while true
                read --prompt-str (log --timestamp --level QUESTION "Choose a destination directory [Default: "(set_color -o magenta)"$PWD/"(set_color --reset)' (Enter)] ') dest
                switch $dest
                    case ''
                        set dest $PWD
                        break
                    case '*'
                        break
                end
            end

            if set --query verbose
                log --timestamp --level INF 'Destination directory set: '(set_color -o)"$dest/"(set_color --reset)
            end
        end

        # The backup destination must be a directory, or not exist.
        if set --query dest && test -e $dest && not test -d $dest
            log --timestamp --level ERR "Backup location must be a directory, but $dest is a file. We won't be able to create a backup directory there."
            notify-send "Backup $arg" $msg[2] -c "transfer.error"
            return 1
        end

        set --query _flag_a && set date_dest $_flag_a
        set --query debug && set --show date_dest

        set dest_with_date "$dest"(printf "$dest_%s" (date +'_%Y%m%d'))
        set --query debug && set --show dest_with_date

        # Ask interactive users if they want the date on the end of their backup directory.
        if set --query interactive && not set --query date_dest
            if user_confirm (log --timestamp --level QUESTION "Append date to destination directory? "(set_color -o magenta)$dest_with_date(set_color --reset))
                set date_dest $_flag_a
                set --query debug && set --show date_dest
            end
        end

        # If user has passed -a/--date_dest, we'll add todays date to the destination folder name.
        if set --query date_dest
            set dest $dest_with_date

            if set --query verbose
                log --timestamp --level INF 'Destination directory updated: '(set_color -o)"$dest/"(set_color --reset)
            end
        end

        # The backup directory doesn't exist, so we'll need to make it.
        if not test -d $dest
            # If we're interactive, ask the user before we create the directory.
            if set --query interactive
                user_confirm --yes \
                    (log --timestamp --level QUESTION "Create backup directory? "(set_color -o magenta)"$dest/"(set_color --reset)) \
                    || return 1
            end

            if set --query dest && not set --query mkdir
                log --timestamp --level ERR "-d/--dest is set, but the directory ("$dest") doesn't exist. Pass -D/--mkdir to create it."
                notify-send "Backup $arg" $msg[2] -c "transfer.error"
                return 1
            end

            # Proceed to creating the directory.
            if set --query dest && set --query mkdir && not set made_dir (mkdir --parents $dest)
                # Destination is set, but we couldn't create the directory. Probably permission issue.
                log --timestamp --level ERR 'Could not make directory: '$dest'. Do you have permission to create this directory?'
                notify-send "Backup $arg" $msg[2] -c "transfer.error"
                return 1
            end
        end

        # Set our datetime now that we're about to create the backup file.
        set datetime_now (printf "%s" (date +$datetime_format))
        set --query debug && set --show datetime_now

        # Set our suffix using our datetime and extension.
        set default_suffix "$datetime_now.$ext"
        set --query _flag_s \
            && set suffix $_flag_s \
            || set suffix $default_suffix
        set --query debug && set --show suffix

        # Construct our default backup file path.
        set new_fname "$arg$suffix"
        set --query debug && set --show new_fname

        # If we've been given a destination, append the basename of $arg to our new destination directory,
        # then add the suffix.
        set --query dest && set new_fname "$dest/"(basename $arg)"$suffix"

        set cp_args $arg $new_fname
        set --query debug && set --show cp_args

        # If $arg is a directory, we need to add -r/--recursive flag.
        test -d $arg && set -p cp_args -r

        # If we're interactive, ask the user before we backup this file/dir.
        if set --query interactive
            user_confirm --yes (log --timestamp --level QUESTION "Create backup? "(set_color -o yellow)$new_fname(set_color --reset)) \
                || return 1
        end

        # Back it up!
        cp $cp_args

        # It failed. :(
        if test $status -ne 0
            log --timestamp --level ERR $arg' -> '$new_fname
            notify-send "Backup $arg" $msg[2] -c "transfer.error"
            return 1
        end

        if not set --query quiet
            log --timestamp --level OK "Backup complete! "(set_color -o yellow)$arg(set_color --reset)' -> '(set_color -o)$new_fname(set_color --reset)
            notify-send "Backup $arg" "Created backup @ $msg[2]" -c "transfer.complete"
        end
    end
end
