function user_confirm --description 'Prompt user to confirm or cancel'
    set opts (fish_opt --short y --long yes --optional-val)

    argparse $opts -- $argv

    if set --query _flag_y
        set default_choice '[Y/n]'
        set yes '' y y
        set no n n
    else
        set default_choice '[y/N]'
        set no '' n n
        set yes y y
    end

    while true
        read --prompt-str "$argv[1] $default_choice" confirm
        switch $confirm
            case $yes
                return 0
            case $no
                return 1
        end
    end
end
