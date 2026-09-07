function log --description 'Log messages (Levels: ERR, INF, WARN, DEBUG, OK, QUESTION)' \
    --argument-names level
    # Nice date format if we want to use it.
    # '['(date --iso-8601=seconds)']:'
    switch $level
        case ERR
            echo (set_color -o red)ERR(set_color --reset) $argv[2..-1]
            return
        case INF
            echo (set_color --bold --dim white)INF(set_color --reset) $argv[2..-1]
            return
        case WARN
            echo (set_color -o yellow)WARN(set_color --reset) $argv[2..-1]
            return
        case DEBUG
            echo (set_color -o cyan)DBG(set_color --reset) $argv[2..-1]
            return
        case OK
            echo (set_color -o green)OK(set_color --reset) $argv[2..-1]
            return
        case QUESTION
            echo (set_color -o cyan)'???'(set_color --reset) $argv[2..-1]
            return
    end
end
