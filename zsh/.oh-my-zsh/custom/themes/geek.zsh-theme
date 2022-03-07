local user_host="%B%(!.%{$fg[cyan]%}.%{$fg[cyan]%})👨 %n%{$reset_color%}"
local current_dir="%B%{$fg[blue]%} in %~ %{$reset_color%}"
local user_symbol='%(!.#.$)'

local line1_start="%{$fg[cyan]%}╭─ %{$reset_color%}"
local line2_start="%{$fg[cyan]%}╰➜%B"
local line1_start_vs="%{$fg[cyan]%}%{$reset_color%}"
local line2_start_vs="%{$fg[cyan]%}➜%B"

local return_error="%(?..🚫)"

local vcs_branch='$(git_prompt_info)$(git_remote_status)'

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
    PROMPT="${line1_start_vs}${user_host}${current_dir}${vcs_branch}
${line2_start_vs}%{$reset_color%}%b "
    RPROMPT="%B${return_error}%b"
else
    PROMPT="${line1_start}${user_host}${current_dir}${vcs_branch}
${line2_start}%{$reset_color%}%b "
    RPROMPT="%B${return_error}%b"
fi

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}on "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" 🚧"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" 🔼"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" 🔽"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=" 🔃"
