if exists("b:did_ftplugin")
  finish
endif

" Behaves just like the C++ plugin
runtime! ftplugin/cpp.vim

let g:compiler_gcc_ignore_unmatched_lines=1
compiler ino
