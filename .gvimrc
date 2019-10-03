"colorscheme golden
"colorscheme lilac
"colorscheme camo
colorscheme inkpot " Inkpot FTW -- http://www.vim.org/scripts/script.php?script_id=1143

"set guifont=-misc-fixed-medium-r-normal-*-*-120-*-*-c-*-iso8859-1 
"set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-120-*-*-m-*-iso8859-1
"set guifont=Andale\ Mono\ 10
set guifont=Literation\ Mono\ Powerline\ 12
set guifontset=-*-*-medium-r-normal-*-9-*-*-*-c-*-*-*
set guioptions+=bi
set mousemodel=popup

set diffopt+=iwhite
set diffexpr=DiffW()
function DiffW()
  let opt = ""
   if &diffopt =~ "icase"
     let opt = opt . "-i "
   endif
   if &diffopt =~ "iwhite"
     let opt = opt . "-w -B " " swapped vim's -b with -w and added -B to ignore blank lines
   endif
   silent execute "!diff -a --binary " . opt .
     \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
endfunction
