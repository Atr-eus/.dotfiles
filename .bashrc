# ENVVARS
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR=/usr/bin/nvim
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
echo "
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⠤⠒⠒⠒⠒⠒⠤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡲⢋⠝⠋⣛⣳⡄⠀⠀⠀⠀⠀⠀⠉⠓⢄⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢀⠠⣴⠗⢀⠥⠂⢁⠤⠤⠤⠁⠀⠀⠀⠀⠀⠀⠀⠀⣛⠛⠉⠗⠒⠲⢤⣀⠀
⠰⠃⠐⠀⠋⡠⠀⠮⠤⠤⠤⠤⡤⡄⠀⠀⠀⠀⠀⠀⢠⣽⠄⠀⠀⠀⠀⠀⢸⡆
⠀⠜⠀⠀⠈⠀⢠⣤⣔⣒⡒⠒⠂⠁⠀⡀⢀⣀⣤⣶⣿⡟⠀⠀⠀⠀⠀⢀⡼⠀
⠈⠀⠀⠀⠀⣰⡿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠉⠁⠀⠀⠀⢄⡴⠋⠀⠀
⠀⠀⠀⠀⣰⠋⠀⠀⠀⠈⠙⠛⠛⠛⠛⠋⠉⠀⠀⠀⠀⢀⣠⣴⡊⠁⠀⠀⠀⠀
⠀⡠⠐⠉⢸⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡀⣤⣶⣿⣿⣿⡻⡄⠀⠀⠀⠀
⠀⠁⠀⠀⣿⢹⣿⣿⣿⣶⣦⣶⣶⣶⣶⣶⣙⠋⠴⠛⣿⢛⡿⠬⠃⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⠘⠹⣿⣿⠛⠛⠛⢿⡇⠀⠉⠀⠘⠉⢰⣯⡊⠙⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠱⡄⠀⠀⠘⠃⠀⠀⠀⠀⠠⠛⠀⠁⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⢲⣄⠀⠒⠂⠀⣀⢴⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣀⣀⣀⣀⣈⠀⢻⣿⣶⣴⣾⡟⢸⣀⣀⣀⣀⣀⣀⡀⠀⠀⠀⠀⠀
⠀⠀⠀⢀⡎⠀⢀⣠⡤⠂⢠⠈⢿⣿⡿⣿⠃⠀⠙⣀⣀⣀⡀⠀⠙⣄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢠⠉⠉⢇⠀⠈⡇⠘⣏⠀⡿⡰⠀⠀⢀⠛⠛⠻⣆⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢸⠉⠉⠉⠗⠒⢿⡀⠸⡈⣠⠧⠞⠉⡏⠉⠉⠉⢹⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀⠁⠀⠉⠉⠀⠀⠈⠀⠀⠀⠀⠸⠀⠀⠀⠀⠀⠀
"

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi
