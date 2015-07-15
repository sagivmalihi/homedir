runtime syntax/grep.vim


syntax match fileName    +^[^:]*+
syntax match fileLine    +:\d\d*:+

highlight fileNameColor ctermfg=Grey guifg=Grey
highlight fileLineColor ctermfg=Green guifg=Green
highlight link fileName fileNameColor
highlight link fileLine fileLineColor

syntax keyword constant True False None
syntax keyword statement if then else endif switch for do while default sizeof try catch throw except raise finally elif with
syntax keyword type class def static register volatile int long char etc struct union enum typedef
syntax keyword todo TODO FIXME XXX

highlight link constant Constant
highlight link statement Statement
highlight link type Type
highlight link todo Todo
