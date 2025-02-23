if status is-interactive
  set -U fish_greeting ""
  fish_vi_key_bindings
  
  set -g -x JAVA_HOME '/usr/lib/jvm/java-23-openjdk/'
  set -g -x PATH_TO_FX '/home/and/.openjfx/javafx-sdk-23.0.2/lib'

  # function fish_prompt
  #   set_color green
  #   echo -n (prompt_pwd)
  #   set_color normal
  #   echo -n '> '
  # end
end
