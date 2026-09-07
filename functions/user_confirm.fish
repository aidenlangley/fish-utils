function user_confirm --description 'Prompt user to confirm or cancel'
    set opts (fish_opt --short y --long yes --optional-val)

    argparse $opts -- $argv

    if set --query _flag_y
        set --global default_choice '[Y/n]'
        set --global yes '' y y
        set --global no n n
    else
        set --global default_choice '[y/N]'
        set --global no '' n n
        set --global yes y y
    end

    while true
        read --local --prompt $argv[1] (format -o $default_choice) confirm
        switch $confirm
            case $yes
                return 0
            case $no
                return 1
        end
    end
end
