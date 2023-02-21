#compdef bookmarks
local context state state_descr line
_bookmarks_commandname=$words[1]
typeset -A opt_args

_bookmarks() {
    integer ret=1
    local -a args
    args+=(
        '(-h --help)'{-h,--help}'[Show help information.]'
        '(-): :->command'
        '(-)*:: :->arg'
    )
    _arguments -w -s -S $args[@] && ret=0
    case $state in
        (command)
            local subcommands
            subcommands=(
                'add:Adds a new bookmark.'
                'remove:Removes a bookmark.'
                'update:Updates a bookmark.'
                'list:Lists all bookmarks.'
                'update-tag:Renames a tag on all of its bookmarks.'
                'list-tags:Lists all tags.'
                'help:Show subcommand help information.'
            )
            _describe "subcommand" subcommands
            ;;
        (arg)
            case ${words[1]} in
                (add)
                    _bookmarks_add
                    ;;
                (remove)
                    _bookmarks_remove
                    ;;
                (update)
                    _bookmarks_update
                    ;;
                (list)
                    _bookmarks_list
                    ;;
                (update-tag)
                    _bookmarks_update-tag
                    ;;
                (list-tags)
                    _bookmarks_list-tags
                    ;;
                (help)
                    _bookmarks_help
                    ;;
            esac
            ;;
    esac

    return ret
}

_bookmarks_add() {
    integer ret=1
    local -a args
    args+=(
        ':title:'
        ':url:'
        '(--tag -t)'{--tag,-t}'[A tag for the bookmark, if you'"'"'d like one.]:tag:{_custom_completion $_bookmarks_commandname ---completion add -- --tag $words}'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_remove() {
    integer ret=1
    local -a args
    args+=(
        ':id:{_custom_completion $_bookmarks_commandname ---completion remove -- id $words}'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_update() {
    integer ret=1
    local -a args
    args+=(
        ':id:{_custom_completion $_bookmarks_commandname ---completion update -- id $words}'
        '(--title -T)'{--title,-T}'[The bookmark'"'"'s new title.]:title:'
        '(--url -u)'{--url,-u}'[The bookmark'"'"'s new URL.]:url:'
        '(--tag -t)'{--tag,-t}'[The bookmark'"'"'s new tag, or '"'"'null'"'"' to remove the current tag.]:tag:{_custom_completion $_bookmarks_commandname ---completion update -- --tag $words}'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_list() {
    integer ret=1
    local -a args
    args+=(
        '(--json -j)'{--json,-j}'[Show output as JSON.]'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_update-tag() {
    integer ret=1
    local -a args
    args+=(
        ':old-tag:{_custom_completion $_bookmarks_commandname ---completion update-tag -- oldTag $words}'
        ':new-tag:'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_list-tags() {
    integer ret=1
    local -a args
    args+=(
        '(--json -j)'{--json,-j}'[Show output as JSON.]'
        '(-h --help)'{-h,--help}'[Show help information.]'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}

_bookmarks_help() {
    integer ret=1
    local -a args
    args+=(
        ':subcommands:'
    )
    _arguments -w -s -S $args[@] && ret=0

    return ret
}


_custom_completion() {
    local completions=("${(@f)$($*)}")
    _describe '' completions
}

_bookmarks
