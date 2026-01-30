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
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk/
export PATH_TO_FX=/usr/lib/jvm/java-21-openjfx/lib/
export VCPKG_ROOT=$HOME/.local/share/vcpkg
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export GLFW_IM_MODULE=fcitx
export XMODIFIERS='@im=fcitx'
# echo "
# "

set -o vi
#
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
then
  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
  exec fish $LOGIN_OPTION
fi
. "$HOME/.cargo/env"
