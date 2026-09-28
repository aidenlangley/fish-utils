function is_number --description 'Check if value is a number'
    string match --quiet --regex '^-?[0-9]+(\.?[0-9]*)?$' -- "$arg"
end
