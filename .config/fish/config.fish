if status is-interactive
  set -U fish_greeting ""
  fish_vi_key_bindings
  
  set -g -x JAVA_HOME '/usr/lib/jvm/java-21-openjdk/'

  # function fish_prompt
  #   set_color green
  #   echo -n (prompt_pwd)
  #   set_color normal
  #   echo -n '> '
  # end
end
