function last_history_item --description 'Repeat last command with sudo, \
  combines with abbr to place last command in prompt'
    echo "sudo $history[1]"
end
