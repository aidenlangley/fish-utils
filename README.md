# fish-utils

A collection of utilities for the fish shell.

## Functions

- backup `backup <FILE> # backs up files and directories`
- format `format --color green --bold OK # convenient way to format text rather than (set_color)...(set_color --reset)`
- !! (last history item)
- log `log DEBUG (echo $argv)`
- mkcd `mkcd new_dir # cd into directory after creation`
- user_confirm `user_confirm Proceed?`

## Abbreviations

- Includes fish-git-abbr ([upstream](https://github.com/lewisacidic/fish-git-abbr))

## Installing

```fish
fisher install aidenlangley/fishutils
```
