# vim:ft=zsh:tw=80:sw=4:sts=4:et:foldmarker=[[[,]]]
__updir() {
    local d="$1"
    local w="$2"
    local n=${3-1}

    if [[ -z "$d" || -z "$w" || ! "$n" =~ -?\[0-9\]\+ ]]; then
        return
    fi

    if [[ ${UP_MATCH_PREFIX-0} -eq 1 ]]; then
        w="^$w"
    fi

    local p="*$w*"
    if [[ "$w" = ^* ]]; then
        p="${w:1}*"
    fi

    d=("${(@s:/:)d}")
    local _start=$#d
    local _end=1
    if (( n < 0 )); then
        _end=$_start
        _start=1
        n=$(( -n ))
    fi

    for x in {$_start..$_end}; do
        if [[ "${d[$x]}" = ${~p} ]]; then
            (( n-- ))
            if (( ! $n )); then
                echo "${(j:/:)d[@]:0:$x}"
                return
            fi
        fi
    done
}

__upnum() {
    local d="$1"
    local n="$2"
    if [[ -z "$d" || "$n" != <-> ]]; then
        return
    fi
    while (( n-- )); do
        d="${d:h}"
    done
    echo "$d"
}

__up_cd() {
    local d="$1"
    if (( ${UP_ECHO_RESULT-0} )); then
        echo "$d"
    fi
    cd "$d"
}

usage() {
    echo -e "usage: up [dir|num] <count>"
}

up() {
    if (( ! $# )); then
        __up_cd ..
        return
    fi

    local d="$(__updir "$PWD" $@)"
    [[ -z "$d" ]] && d="$(__upnum "$PWD" "$1")"

    if [ -d "$d" ]; then
        __up_cd "$d"
        return
    fi

    usage
}

_up() {
    local p=(${(@s:/:)PWD})
    _wanted -V values expl 'foo' compadd -a p
}

compdef _up up
