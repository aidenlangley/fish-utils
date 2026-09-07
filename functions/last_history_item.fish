function last_history_item --description 'Repeat last command, combines with \
  abbr to place last command in prompt'
    echo $history[1]
end
