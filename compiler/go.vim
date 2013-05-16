" Vim compiler file

if exists("current_compiler")
  finish
endif
let current_compiler = "go"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=if\ [\ -z\ \"$*\"\ ];\ then\ go\ install;\ else\ go\ $*;\ fi

CompilerSet errorformat=
      \%f:%l:%c:%m,
      \%f:%l%m,%-G#%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
