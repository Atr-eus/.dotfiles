if status is-interactive
  set -U fish_greeting ""
  fish_vi_key_bindings

  function fish_prompt
    set_color green
    echo -n (prompt_pwd)
    set_color normal
    echo -n '> '
  end
end
