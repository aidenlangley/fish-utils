function mkcd --description 'Create a directory and cd into it'
    mkdir $argv

    if test $status = 0
        switch $argv[(count $argv)]
            case '-*'
            case '*'
                cd $argv[(count $argv)]
                return
        end
    end
end
