function get_idf --wraps='export IDF_PATH=/home/and/esp/esp-idf && . /home/and/esp/esp-idf/export.fish' --description 'alias get_idf=export IDF_PATH=/home/and/esp/esp-idf && . /home/and/esp/esp-idf/export.fish'
  export IDF_PATH=/home/and/esp/esp-idf && . /home/and/esp/esp-idf/export.fish $argv
        
end
