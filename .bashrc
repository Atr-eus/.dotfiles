# ENVVARS
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache
export EDITOR=/usr/bin/nvim
export TERM=xterm-256color
export HISTFILE="${XDG_STATE_HOME}"/bash/history
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark
export LC_ALL=en_US.UTF-8
export MANPAGER='nvim +Man!'
export IDF_PATH=$HOME/esp/esp-idf
export JAVA_HOME=/usr/lib/jvm/java-23-openjdk/
export PATH_TO_FX=/usr/lib/jvm/java-23-openjfx/lib/
export VCPKG_ROOT=$HOME/.local/share/vcpkg
# echo "
# "

set -o vi

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi
. "$HOME/.cargo/env"
