# These utilities are only for interactive mode.
if not status is-interactive && test "$CI" != true
    exit
end

function _install_git_add --description 'Configure git add abbreviations'
    abbr --command git a add
    abbr --command git aa 'add -v --all # add all files to the index'
    abbr --command git apa 'add -v --patch # interactively add files to the index'
    abbr --command git au 'add -v --update # update index if files exist'
end

function _uninstall_git_add --description 'Uninstall git add abbreviations'
    abbr --command git --erase a
    abbr --command git --erase aa
    abbr --command git --erase apa
    abbr --command git --erase au
end

function _install_git_apply --description 'Configure git apply abbreviations'
    abbr --command git ap apply
    abbr --command git apt 'apply --3way'
end

function _uninstall_git_apply --description 'Uninstall git apply abbreviations'
    abbr --command git --erase ap
    abbr --command git --erase apt
end

function _install_git_branch --description 'Configure git branch abbreviations'
    abbr --command git b branch
    abbr --command git bD --set-cursor 'branch --description % # delete branch w/ force'
    abbr --command git bD! --set-cursor 'branch --description -f % # delete branch w/ more force '
    abbr --command git ba 'branch --add # list remote and local branches'
    abbr --command git bd --set-cursor 'branch --description % # delete branch'
    abbr --command git bnm 'branch --no-merged # only list branches that aren\'t reachable from HEAD'
    abbr --command git br 'branch --remotes # interact with remote branches'
    abbr --command git brD --set-cursor 'branch --remotes --description % # delete remote branch w/ force'
    abbr --command git brD! --set-cursor 'branch --description -f % # delete remote branch w/ more force '
    abbr --command git brd --set-cursor 'branch --remotes --description % # delete remote branch'
    abbr --command git brv 'branch -l -vv # list remote branches w/ verbosity'
    abbr --command git bv 'branch -l -vv # list branches w/ verbosity'
end

function _uninstall_git_branch --description 'Uninstall git branch abbreviations'
    abbr --command git --erase b
    abbr --command git --erase bD
    abbr --command git --erase bD!
    abbr --command git --erase ba
    abbr --command git --erase bd
    abbr --command git --erase bnm
    abbr --command git --erase br
    abbr --command git --erase brD
    abbr --command git --erase brD!
    abbr --command git --erase brd
    abbr --command git --erase brv
    abbr --command git --erase bv
end

function _install_git_bisect --description 'Configure git bisect abbreviations'
    abbr --command git bs --set-cursor 'bisect % # find bugs'
    abbr --command git bsb 'bisect bad # current version is bad'
    abbr --command git bsg --set-cursor 'bisect good % # this version is known to be good'
    abbr --command git bsr 'bisect reset # clean up bisection state and return to original HEAD after bisecting'
    abbr --command git bss 'bisect start # start looking for bugs via bisecting'
end

function _uninstall_git_bisect --description 'Uninstall git bisect abbreviations'
    abbr --command git --erase bs
    abbr --command git --erase bsb
    abbr --command git --erase bsg
    abbr --command git --erase bsr
    abbr --command git --erase bss
end

function _install_git_commit --description 'Configure git commit abbreviations'
    abbr --command git c 'commit -v'
    abbr --command git c! 'commit -v --amend # commit + amend'
    abbr --command git ca 'commit --add -v # commit + stage all'
    abbr --command git ca! 'commit --add -v --amend # commit + stage all + amend'
    abbr --command git cam --set-cursor "commit --add -m '%' # commit w/ message"
    abbr --command git can! 'commit --add -v --no-edit --amend # commit + stage all + amend without changing commit message'
    abbr --command git cans! 'commit --add -v -s --no-edit --amend # commit + stage all + amend without changing commit message + signoff the commit'
    abbr --command git cas 'commit --add -s # commit + stage all + signoff the commit'
    abbr --command git casm --set-cursor "commit --add -s -m '%' # commit /w message + stage all + signoff the commit"
    abbr --command git ci 'commit --allow-empty -v -m\'chore: initial commit\' # blank initial commit'
    abbr --command git cm --set-cursor "commit -m '%' # commit /w message"
    abbr --command git cn 'commit -v --no-edit # include staged changes in previous commit'
    abbr --command git cn! 'commit -v --amend --no-edit # include staged changes in previous commit + amend'
    abbr --command git cs 'commit -S # GPG sign the commit'
    abbr --command git csm --set-cursor "commit -s -m '%' # commit w/ message + sign off the commit"
end

function _uninstall_git_commit --description 'Uninstall git commit abbreviations'
    abbr --command git --erase c
    abbr --command git --erase c!
    abbr --command git --erase ca
    abbr --command git --erase ca!
    abbr --command git --erase cam
    abbr --command git --erase can!
    abbr --command git --erase cans!
    abbr --command git --erase cas
    abbr --command git --erase casm
    abbr --command git --erase ci
    abbr --command git --erase cm
    abbr --command git --erase cn
    abbr --command git --erase cn!
    abbr --command git --erase cs
    abbr --command git --erase csm
end

function _install_git_clean --description 'Configure git clean abbreviations'
    abbr --command git cleand 'clean --description # recursively remove untracked files'
    abbr --command git cleandi 'clean -di # interactively (and recursively) remove untracked files'
    abbr --command git cleani 'clean -i # interactively remove untracked files'
end

function _uninstall_git_clean --description 'Uninstall git clean abbreviations'
    abbr --command git --erase cleand
    abbr --command git --erase cleandi
    abbr --command git --erase cleani
end

function _install_git_checkout --description 'Configure git checkout abbreviations'
    abbr --command git co checkout
    abbr --command git coB --set-cursor 'checkout -B % (git_current_branch) # copy current branch and reset it, then checkout'
    abbr --command git cob --set-cursor 'checkout -b % (git_current_branch) # copy current branch then checkout'
    abbr --command git cod 'checkout (git_develop_branch)'
    abbr --command git cof --set-cursor 'checkout (git_feature_prepend)/%'
    abbr --command git coh --set-cursor 'checkout hotfix/%'
    abbr --command git com 'checkout (git_main_branch)'
    abbr --command git cor --set-cursor 'checkout release/%'
    abbr --command git cors 'checkout --recurse-submodules'
    abbr --command git cos --set-cursor 'checkout support/%'
end

function _uninstall_git_checkout --description 'Uninstall git checkout abbreviations'
    abbr --command git --erase co
    abbr --command git --erase coB
    abbr --command git --erase cob
    abbr --command git --erase cod
    abbr --command git --erase cof
    abbr --command git --erase coh
    abbr --command git --erase com
    abbr --command git --erase cor
    abbr --command git --erase cors
    abbr --command git --erase cos
end

function _install_git_shortlog --description 'Configure git shortlog abbreviations'
    abbr --command git sh --set-cursor 'shortlog % # presentable summary'
    abbr --command git count 'shortlog -sn # authors + commit count'
end

function _uninstall_git_shortlog --description 'Uninstall git shortlog abbreviations'
    abbr --command git --erase sh
    abbr --command git --erase count
end

function _install_git_cherrypick --description 'Configure git cherry-pick abbreviations'
    abbr --command git cp --set-cursor 'cherry-pick % # apply changes from another commit to working tree'
    abbr --command git cpa 'cherry-pick --abort'
    abbr --command git cpc 'cherry-pick --continue'
    abbr --command git cpe 'cherry-pick --edit # edit the cherry-picked commit'
end

function _uninstall_git_cherrypick --description 'Uninstall git cherry-pick abbreviations'
    abbr --command git --erase cp
    abbr --command git --erase cpa
    abbr --command git --erase cpc
    abbr --command git --erase cpe
end

function _install_git_diff --description 'Configure git diff abbreviations'
    abbr --command git d diff
    abbr --command git dca 'diff --cached'
    abbr --command git dct 'diff --staged'
    abbr --command git dcw 'diff --cached --word-diff'
    abbr --command git dt 'diff-tree --no-commit-id --name-only -r'
    abbr --command git dup 'diff @{upstream}'
end

function _uninstall_git_diff --description 'Uninstall git diff abbreviations'
    abbr --command git --erase d
    abbr --command git --erase dca
    abbr --command git --erase dct
    abbr --command git --erase dcw
    abbr --command git --erase dt
    abbr --command git --erase dup
end

function _install_git_fetch --description 'Configure git fetch abbreviations'
    abbr --command git f fetch
    abbr --command git fa 'fetch --all --prune'
    abbr --command git fo 'fetch origin'
end

function _uninstall_git_fetch --description 'Uninstall git fetch abbreviations'
    abbr --command git --erase f
    abbr --command git --erase fa
    abbr --command git --erase fo
end

function _install_git_log --description 'Configure git log abbreviations'
    abbr --command git l --set-cursor 'log % # commit log'
    abbr --command git lg 'log --graph --decorate --all # logs (all) /w graph'
    abbr --command git lgm --set-cursor 'log --graph --max-count=10% # logs w/ graph + limit'
    abbr --command git lo 'log --oneline --decorate # logs w/ compact one liners'
    abbr --command git log 'log --oneline --decorate --graph # logs w/ graph + compact one liners'
    abbr --command git loga 'log --oneline --decorate --graph --all # logs (all) w/ graph + compact one liners'
    abbr --command git ls 'log --stat # logs /w change stats'
    abbr --command git lsp 'log --stat -p # logs /w stats + preview'
end

function _uninstall_git_log --description 'Uninstall git log abbreviations'
    abbr --command git --erase l
    abbr --command git --erase lg
    abbr --command git --erase lgm
    abbr --command git --erase lo
    abbr --command git --erase log
    abbr --command git --erase loga
    abbr --command git --erase ls
    abbr --command git --erase lsp
end

function _install_git_merge --description 'Configure git merge abbreviations'
    abbr --command git m merge
    abbr --command git ma 'merge --abort # abort and rollback the merge'
    abbr --command git mc 'merge --continue # continue after resolving a conflict'
    abbr --command git mom 'merge origin/(git_main_branch) # merge main branch into current branch'
    abbr --command git mum 'merge upstream/(git_main_branch) # merge main branch (upstream) into current branch'

    abbr --command git mtl 'mergetool --no-prompt'
    abbr --command git mtlvim 'mergetool --no-prompt --tool=vimdiff'
end

function _uninstall_git_merge --description 'Uninstall git merge abbreviations'
    abbr --command git --erase m
    abbr --command git --erase ma
    abbr --command git --erase mc
    abbr --command git --erase mom
    abbr --command git --erase mum

    abbr --command git --erase mtl
    abbr --command git --erase mtlvim
end

function _install_git_push --description 'Configure git push abbreviations'
    abbr --command git p push
    abbr --command git pd 'push --dry-run'
    abbr --command git pf 'push --force-with-lease'
    abbr --command git pf! 'push --force'
    abbr --command git poat 'push origin --all && git push origin --tags'
    abbr --command git poatf! 'push origin --all --force && git push origin --tags --force'
    abbr --command git poatf! 'push origin --all --force-with-lease && git push origin --tags --force-with-lease'
    abbr --command git psu 'push --set-upstream origin (git_current_branch)'
    abbr --command git pt 'push --tags'
    abbr --command git ptf 'push --tags --force-with-lease'
    abbr --command git ptf! 'push --tags --force'
    abbr --command git pv 'push -v'
end

function _uninstall_git_push --description 'Uninstall git push abbreviations'
    abbr --command git --erase p
    abbr --command git --erase pd
    abbr --command git --erase pf
    abbr --command git --erase pf!
    abbr --command git --erase poat
    abbr --command git --erase poatf!
    abbr --command git --erase poatf!

    abbr --command git --erase pt
    abbr --command git --erase ptf
    abbr --command git --erase ptf!
    abbr --command git --erase pv
end

function _install_git_pull --description 'Configure git pull abbreviations'
    abbr --command git pl pull
    abbr --command git plo 'pull origin'
    abbr --command git plom 'pull origin (git_main_branch)'
    abbr --command git plu 'pull upstream'
    abbr --command git plum 'pull upstream (git_main_branch)'
end

function _uninstall_git_pull --description 'Uninstall git pull abbreviations'
    abbr --command git --erase pl
    abbr --command git --erase plo
    abbr --command git --erase plom
    abbr --command git --erase plu
    abbr --command git --erase plum
end

function _install_git_remote --description 'Configure git remote abbreviations'
    abbr --command git r 'remote -v'
    abbr --command git ra 'remote add'
    abbr --command git rau 'remote add upstream'
    abbr --command git rmv 'remote rename'
    abbr --command git rrm 'remote remove'
    abbr --command git rset 'remote set-url'
    abbr --command git ru 'remote update'
    abbr --command git rv 'remote -v'
    abbr --command git rvv 'remote -vvv'
end

function _uninstall_git_remote --description 'Uninstall git remote abbreviations'
    abbr --command git --erase r
    abbr --command git --erase ra
    abbr --command git --erase rau
    abbr --command git --erase rmv
    abbr --command git --erase rrm
    abbr --command git --erase rset
    abbr --command git --erase ru
    abbr --command git --erase rv
    abbr --command git --erase rvv
end

function _install_git_rebase --description 'Configure git rebase abbreviations'
    abbr --command git rb rebase
    abbr --command git rba 'rebase --abort'
    abbr --command git rbc 'rebase --continue'
    abbr --command git rbd 'rebase (git_develop_branch)'
    abbr --command git rbi 'rebase -i'
    abbr --command git rbo 'rebase --onto'
    abbr --command git rbom 'rebase origin/(git_main_branch)'
    abbr --command git rbs 'rebase --skip'
end

function _uninstall_git_rebase --description 'Uninstall git rebase abbreviations'
    abbr --command git --erase rb
    abbr --command git --erase rba
    abbr --command git --erase rbc
    abbr --command git --erase rbd
    abbr --command git --erase rbi
    abbr --command git --erase rbo
    abbr --command git --erase rbom
    abbr --command git --erase rbs
end

function _install_git_reset --description 'Configure git reset and revert abbreviations'
    abbr --command git rs reset
    abbr --command git pristine 'reset --hard && git clean -dffx'
    abbr --command git rs! 'reset --hard'
    abbr --command git rs- 'reset --'
    abbr --command git rsh 'reset HEAD^'
    abbr --command git rsh! 'reset --hard HEAD^'
    abbr --command git rsoh 'reset origin/(git_current_branch)'
    abbr --command git rsoh! 'reset origin/(git_current_branch) --hard'
    abbr --command git rss 'reset --soft'
    abbr --command git rssh 'reset --soft HEAD^'

    abbr --command git undo 'reset HEAD^'
    abbr --command git undos 'reset --soft HEAD^'
    abbr --command git undo! 'reset --hard HEAD^'

    abbr --command git rev revert
end

function _uninstall_git_reset --description 'Uninstall git reset and revert abbreviations'
    abbr --command git --erase rs
    abbr --command git --erase pristine
    abbr --command git --erase rs!
    abbr --command git --erase rs-
    abbr --command git --erase rsh
    abbr --command git --erase rsh!
    abbr --command git --erase rsoh
    abbr --command git --erase rsoh!
    abbr --command git --erase rss
    abbr --command git --erase rssh

    abbr --command git --erase undo
    abbr --command git --erase undos
    abbr --command git --erase undo!

    abbr --command git --erase rev
end

function _install_git_rm --description 'Configure git rm abbreviations'
    abbr --command git rm rm
    abbr --command git rmc 'rm --cached'
end

function _uninstall_git_rm --description 'Uninstall git rm abbreviations'
    abbr --command git --erase rm
    abbr --command git --erase rmc
end

function _install_git_restore --description 'Configure git restore abbreviations'
    abbr --command git rst restore
    abbr --command git rsts 'restore --source'
    abbr --command git rstst 'restore --staged'
end

function _uninstall_git_restore --description 'Uninstall git restore abbreviations'
    abbr --command git --erase rst
    abbr --command git --erase rsts
    abbr --command git --erase rstst
end

function _install_git_status --description 'Configure git status abbreviations'
    abbr --command git s status
    abbr --command git sb 'status -sb'
    abbr --command git ss 'status -s'
end

function _uninstall_git_status --description 'Uninstall git status abbreviations'
    abbr --command git --erase s
    abbr --command git --erase sb
    abbr --command git --erase ss
end

function _install_git_show --description 'Configure git show abbreviations'
    abbr --command git show show
    abbr --command git showps 'show --pretty=short --show-signature'
end

function _uninstall_git_show --description 'Uninstall git show abbreviations'
    abbr --command git --erase show
    abbr --command git --erase showps
end

function _install_git_stash --description 'Configure git stash abbreviations'
    abbr --command git st stash
    abbr --command git sta 'stash apply'
    abbr --command git stall 'stash --all'
    abbr --command git stc 'stash clear'
    abbr --command git std 'stash drop'
    abbr --command git stl 'stash list'
    abbr --command git stshow 'stash show --text'

    abbr --add git_stash_pop -r 'stP|sto' --command git 'stash pop'
    abbr --add git_stash_push -r 'stp|stu' --command git --set-cursor "stash push -m '%'"
end

function _uninstall_git_stash --description 'Uninstall git stash abbreviations'
    abbr --command git --erase st
    abbr --command git --erase sta
    abbr --command git --erase stall
    abbr --command git --erase stc
    abbr --command git --erase std
    abbr --command git --erase stl
    abbr --command git --erase stshow

    abbr --erase git_stash_pop
    abbr --erase git_stash_push
end

function _install_git_switch --description 'Configure git switch abbreviations'
    abbr --command git sw switch
    abbr --command git swc 'switch -c'
    abbr --command git swd 'switch (git_develop_branch)'
    abbr --command git swm 'switch (git_main_branch)'
end

function _uninstall_git_switch --description 'Uninstall git switch abbreviations'
    abbr --command git --erase sw
    abbr --command git --erase swc
    abbr --command git --erase swd
    abbr --command git --erase swm
end

function _install_git_tag --description 'Configure git tag abbreviations'
    abbr --command git t tag
    abbr --command git ta 'tag -a'
    abbr --command git tas 'tag --add -s'
    abbr --command git ts 'tag -s'
end

function _uninstall_git_tag --description 'Uninstall git tag abbreviations'
    abbr --command git --erase t
    abbr --command git --erase ta
    abbr --command git --erase tas
    abbr --command git --erase ts
end

function _install_git_worktree --description 'Configure git worktree abbreviations'
    abbr --command git wt worktree
    abbr --command git wta 'worktree add'
    abbr --command git wtls 'worktree list'
    abbr --command git wtmv 'worktree move'
    abbr --command git wtrm 'worktree remove'
end

function _uninstall_git_worktree --description 'Uninstall git worktree abbreviations'
    abbr --command git --erase wt
    abbr --command git --erase wta
    abbr --command git --erase wtls
    abbr --command git --erase wtmv
    abbr --command git --erase wtrm
end

function _install_git_am --description 'Configure git am abbreviations (mailbox patches)'
    abbr --command git am am
    abbr --command git ama 'am --abort'
    abbr --command git amc 'am --continue'
    abbr --command git ams 'am --skip'
    abbr --command git amscp 'am --show-current-patch'
end

function _uninstall_git_am --description 'Uninstall git am abbreviations (mailbox patches)'
    abbr --command git --erase am
    abbr --command git --erase ama
    abbr --command git --erase amc
    abbr --command git --erase ams
    abbr --command git --erase amscp
end

function _install_git_flags --description 'Configure modifiers like quiet and dry-run'
    abbr --command git C --set-cursor -- --path=%
    abbr --command git dr -- --dry-run
    abbr --command git q -- --quiet
end

function _uninstall_git_flags --description 'Uninstall modifiers like quiet and dry-run'
    abbr --command git --erase C
    abbr --command git --erase dr
    abbr --command git --erase q
end

abbr g git

_install_git_add
_install_git_am
_install_git_apply
_install_git_bisect
_install_git_branch
_install_git_checkout
_install_git_cherrypick
_install_git_clean
_install_git_commit
_install_git_diff
_install_git_fetch
_install_git_flags
_install_git_log
_install_git_merge
_install_git_pull
_install_git_push
_install_git_rebase
_install_git_remote
_install_git_reset
_install_git_restore
_install_git_rm
_install_git_shortlog
_install_git_stash
_install_git_status
_install_git_switch
_install_git_tag
_install_git_worktree

abbr --command git bl 'blame -b -w'
abbr --command git cf 'config --list'
abbr --command git cl 'clone --recurse-submodules'
abbr --command git dct 'describe --tags (git rev-list --tags --max-count=1)'
abbr --command git fg 'ls-files | grep % # find files'
abbr --command git i init
abbr --command git ignore 'update-index --assume-unchanged'
abbr --command git ignored 'ls-files -v | grep "^[[:lower:]]"'
abbr --command git rt 'cd (git rev-parse --show-toplevel || echo .)'
abbr --command git su 'submodule update'
abbr --command git wch 'whatchanged -p --abbrev-commit --pretty=medium'

abbr gk 'gitk --all --branches &!'
abbr gke 'gitk  --all (git log -g --pretty=%h) &!'

function _git_abbr_uninstall --on-event git_abbr_uninstall
    set --erase __git_abbr_version

    functions --erase git_current_branch
    functions --erase git_main_branch
    functions --erase git_develop_branch
    functions --erase git_feature_branch_prepend

    _uninstall_git_add
    _uninstall_git_am
    _uninstall_git_apply
    _uninstall_git_bisect
    _uninstall_git_branch
    _uninstall_git_checkout
    _uninstall_git_cherrypick
    _uninstall_git_clean
    _uninstall_git_commit
    _uninstall_git_diff
    _uninstall_git_fetch
    _uninstall_git_flags
    _uninstall_git_log
    _uninstall_git_merge
    _uninstall_git_pull
    _uninstall_git_push
    _uninstall_git_rebase
    _uninstall_git_remote
    _uninstall_git_reset
    _uninstall_git_restore
    _uninstall_git_rm
    _uninstall_git_shortlog
    _uninstall_git_stash
    _uninstall_git_status
    _uninstall_git_switch
    _uninstall_git_tag
    _uninstall_git_worktree

    abbr --command git --erase bl
    abbr --command git --erase cf
    abbr --command git --erase cl
    abbr --command git --erase dct
    abbr --command git --erase fg
    abbr --command git --erase i
    abbr --command git --erase ignore
    abbr --command git --erase ignored
    abbr --command git --erase rt
    abbr --command git --erase su
    abbr --command git --erase wch

    abbr --erase gk
    abbr --erase gke
end
