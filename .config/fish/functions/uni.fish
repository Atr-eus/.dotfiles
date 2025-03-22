function uni --wraps=/run/mount/uni/1-2/ --wraps='cd /run/mount/uni/1-2/' --wraps='cd /run/mount/uni/1-2/ && ll -a' --description 'alias uni=cd /run/mount/uni/1-2/ && ll -a'
  cd /run/mount/uni/1-2/ && ll -a $argv
        
end
