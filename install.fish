#! /usr/bin/env fish

set plugin aidenlangley/fish-utils

switch $argv
    case local
        fisher remove $plugin
        fisher install $PWD
    case remote
        fisher remove $PWD
        fisher install $plugin
    case '*'
        echo (set_color -o red)ERR(set_color --reset)' Must pass either local or remote'
end
