# These utilities are only for interactive mode.
if not status is-interactive && test "$CI" != true
    exit
end

set --global __datetime_abbr_version 1.0.0

abbr --add day --position anywhere 'date +\'%d\''
abbr --add weekday --position anywhere 'date +\'%A\''
abbr --add weekdayshort --position anywhere 'date +\'%a\''
abbr --add week --position anywhere 'date +\'%V\''
abbr --add month --position anywhere 'date +\'%B\''
abbr --add monthshort --position anywhere 'date +\'%b\''
abbr --add year --position anywhere 'date +\'%G\''
abbr --add yday --position anywhere 'date +\'%j\''
abbr --add ymonth --position anywhere 'date +\'%m\''
abbr --add quarter --position anywhere 'date +\'%q\''

abbr --add hour --position anywhere 'date +\'%I%p\''
abbr --add 24hour --position anywhere 'date +\'%H\''
abbr --add min --position anywhere 'date +\'%M\''
abbr --add sec --position anywhere 'date +\'%S\''
abbr --add ns --position anywhere 'date +\'%N\''

abbr --add isodate --position anywhere --set-cursor 'date --iso-8601'
abbr --add rfcdate --position anywhere --set-cursor 'date --rfc-3339=date'
abbr --add isodth --position anywhere 'date --iso-8601=hours'
abbr --add isodtm --position anywhere 'date --iso-8601=minutes'
abbr --add isodts --position anywhere 'date --iso-8601=seconds'
abbr --add rfcdts --position anywhere 'date --rfc-3339=seconds'
abbr --add isodtns --position anywhere 'date --iso-8601=ns'
abbr --add rfcdtns --position anywhere 'date --rfc-3339=ns'
abbr --add emaildt --position anywhere 'date --rfc-email'

abbr --add time --position anywhere 'date +\'%T\''
abbr --add localtime --position anywhere 'date +\'%r\''
abbr --add 24time --position anywhere 'date +\'%R\''

abbr --add epoch --position anywhere 'date +\'%s\''

abbr --add tzstr --position anywhere 'date +\'%Z\''
abbr --add tz --position anywhere 'date +\'%Z%z\''
abbr --add tzz --position anywhere 'date +\'%Z%:z\''
abbr --add tzzz --position anywhere 'date +\'%Z%::z\''
abbr --add tzzzz --position anywhere 'date +\'%Z%:::z\''
abbr --add tzoffset --position anywhere 'date +\'%z\''
abbr --add tzzoffset --position anywhere 'date +\'%:z\''
abbr --add tzzzoffset --position anywhere 'date +\'%::z\''
abbr --add tzzzzoffset --position anywhere 'date +\'%:::z\''

abbr --add datef --position anywhere --set-cursor=^ "date +'%^'"
abbr --add lastmod --position anywhere --set-cursor 'date --iso-8601=date --reference=%'

abbr --command date u -- --utc
abbr --command date --set-cursor d -- --date=%
abbr --command date D -- --debug
abbr --command date --set-cursor f -- --file=%
abbr --command date --set-cursor str -- --set=%

function _datetime_uninstall --on-event datetime_abbr_uninstall
    abbr --erase day
    abbr --erase weekday
    abbr --erase weekdayshort
    abbr --erase week
    abbr --erase month
    abbr --erase monthshort
    abbr --erase year
    abbr --erase yday
    abbr --erase ymonth
    abbr --erase quarter

    abbr --erase hour
    abbr --erase 24hour
    abbr --erase min
    abbr --erase sec
    abbr --erase ns

    abbr --erase isodate
    abbr --erase rfcdate
    abbr --erase isodth
    abbr --erase isodtm
    abbr --erase isodts
    abbr --erase rfcdts
    abbr --erase isodtns
    abbr --erase rfcdtns
    abbr --erase emaildt

    abbr --erase time
    abbr --erase localtime
    abbr --erase 24time

    abbr --erase epoch

    abbr --erase tzstr
    abbr --erase tz
    abbr --erase tzz
    abbr --erase tzzz
    abbr --erase tzzzz
    abbr --erase tzoffset
    abbr --erase tzzoffset
    abbr --erase tzzzoffset
    abbr --erase tzzzzoffset

    abbr --erase datef
    abbr --erase lastmod

    abbr --command date --erase u
    abbr --command date --erase d
    abbr --command date --erase D
    abbr --command date --erase f
    abbr --command date --erase str
end
