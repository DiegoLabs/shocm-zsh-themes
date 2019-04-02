ZSH_THEME_GIT_PROMPT_PREFIX="git: "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[cyan]%}▴%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}▾%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"

GIT_ROOT () {
    basename $(git rev-parse --show-toplevel)
}

LOWERCASE () {
    echo $1 | sed -E 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'
}

PATH_INFO () {
    local HOME_PATH=%~
    if [[ $PWD/ = /Users/* ]]; then
        local HOME_PATH=$(echo $PWD | sed 's/\/Users\/[a-zA-Z]*/▶︎/')
    fi

    local DIR=%{$fg[cyan]%}$HOME_PATH%{$reset_color%}

    if [ -n "$(git_prompt_info)" ]; then
        local ROOT=$(GIT_ROOT)

        if [ "$(LOWERCASE "$ROOT")" != "$(LOWERCASE "${PWD##*/}")" ]; then
            DIR="︎%{$fg[cyan]%}$ROOT%{$reset_color%}/${PWD/*$ROOT\//}"
        else
            DIR="$ROOT"
        fi
    fi

    echo "%{$fg[cyan]%}$DIR%{$reset_color%}"
}

PROMPT='%{$fg[$NCOLOR]%}%c%{$fg[magenta]%}>%{$reset_color%} '

RPROMPT='%{$fg[$NCOLOR]%}%p $(git_prompt_info)$(git_prompt_status)%{$reset_color%}'

