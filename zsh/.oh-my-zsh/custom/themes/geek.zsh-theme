local user_host="%B%(!.%{$fg[cyan]%}.%{$fg[cyan]%})%n in %{$reset_color%}"
local current_dir="%B%{$fg[blue]%}%~ %{$reset_color%}"
local user_symbol='%(!.#.$)'

local line1_start="%{$fg[cyan]%}╭─ %{$reset_color%}"
local line2_start="%{$fg[cyan]%}╰➜%B"

local return_error="%(?..🚫)"

local vcs_branch='$(git_prompt_info)$(hg_prompt_info)'

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    PROMPT="${current_dir}➜ "
else
    PROMPT="${line1_start}${user_host}${current_dir}${vcs_branch}
${line2_start}%{$reset_color%}%b "
    RPROMPT="%B${return_error}%b"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}on "
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} 🚧%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

ZSH_THEME_HG_PROMPT_PREFIX="$ZSH_THEME_GIT_PROMPT_PREFIX"
ZSH_THEME_HG_PROMPT_SUFFIX="$ZSH_THEME_GIT_PROMPT_SUFFIX"
ZSH_THEME_HG_PROMPT_DIRTY="$ZSH_THEME_GIT_PROMPT_DIRTY"
ZSH_THEME_HG_PROMPT_CLEAN="$ZSH_THEME_GIT_PROMPT_CLEAN"
