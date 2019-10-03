" temporarily disable minibufexplorer for large swathes of file edits
"let loaded_minibufexplorer = 1

" disable spelling for this file in vim 7
" vim700: set nospell :
"
"If you are viewing this file on the web, DO NOT "save as..." -- it has
"embedded control characters that do not save well as plain text. Instead, go back
"one page and chose the right-click "save link target as..." from the popup
"menu, OR use the commandline wget tool if you were given the link to this
"file directly; in other words:  (wget http://webdragon.net/miscel/vimrc.txt)
"
"Note: my work environment includes a number of _strange preferences_ that you
"may or may not find normal. I don't recommend that you USE this as YOUR
".vimrc, but rather that you steal ideas from it for your own, and keep it as
"reference material, if anything.

" Disable vi compatibility to enable extended vim features
" Note that this isn't really necessary, as the use of a ~/.vimrc sets this automatically
set nocompatible 

let cpo_save=&cpo
set cpo=B
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>

" import my web-automation mappings -- disabled as of Feb 2007
" as I moved these to ~/.vim/ftplugin/html.vim, which updates are
" forthcoming to my website links. stay tuned. 
"if filereadable( expand( expand( "<sfile>:h") . "/.vimrc.web") )
":source <sfile>:h/.vimrc.web
"endif

" Always change to the directory the file in your current buffer is in
"au BufEnter * :cd %:p:h

" revised 2006-11-29 based on suggestions from #vim
"noremap <F12> :cd %:p:h<CR>
" revised back again 2007-02-17 when it was (re)discovered WHY this is necessary: 
" try vim .vim/ftplugin/html.vim and then try using <f12> with only the above map.
" can't do it, can you? that is why we need the below:
" map 'F12' to change the pwd of vim to the cwd of the current file
noremap <F12> :cd <C-R>=expand("%:p:h")<CR><CR>

" map 'F9' to toggle un/wrapping the text lines
noremap <F9> :set wrap!<CR>
" make vim wrap long lines at a character in 'breakat' rather than the last char that fits on the screen
set linebreak

set nohlsearch " do not highlight searches by default
" add a toggle to turn it on and off, though
noremap <F7> :set hls! 
set is "DO highlight while typing search characters

" map 'visual-selection' + 'F8' so that it will uppercase the first letter of every word on the current selection
" similar to using :.!perl -pe 'local $\ = " "; print ucfirst for split / /;', but slightly more efficient :-)
" no no no, this won't work at all --  vnoremap <F8> : s/'\@<!\<[a-z]/\u&/g 
" kudos to <frogonwheels> from #vim as this will work even on <C-v> selections
fun! InitUpperSelection() range
  let oldx=getreg('x')
  let oldxtype=getregtype('x')
  norm gv"xd
  call setreg('x', 
\ substitute( getreg('x'),'''\@<!\<[a-z]','\u&','g'),getregtype('x'))
  norm "xP
  call setreg('x',oldx,oldxtype)
endfun

vmap <f8> <ESC>:call InitUpperSelection()<CR>

" map ctrl-left ctrl-right to move to next/prev buffers
" fix for console/terminal first, though
map Oc <C-Right>
map Od <C-Left>
noremap <C-Right> :bn<CR>_
noremap <C-Left> :bp<CR>_

" map [d <C-S-Left>
" map [c <C-S-Right>
" noremap <C-S-Left> :tabprevious<CR>
" noremap <C-S-Right> :tabnext<CR>

" Be certain these two lines have no trailing spaces
" Rehighlight visual block after left/right shift
vnoremap < <gv
vnoremap > >gv

"make it so that jk, instead of navigating across actual lines, allows you
"to scroll up/down visual lines... so if you have a really long wrapped line,
"you can actually scroll down through it
nnoremap <Down> gj
nnoremap <Up> gk
inoremap <Down> <Esc>gja
inoremap <Up> <Esc>gka
" leave these alone so you have one that goes line-by-physical-line and one
" that goes line-by-wrapped-line
"nnoremap j gj
"nnoremap k gk

"cycle through open buffer windows, whether split horizontally or vertically,
"similar to alt-tab. also see set wiw and set wh for more usefulness, below.
map <C-N> <C-W>w

" swap the word the cursor is on with the next word (which can be on a newline, and punctuation is 'skipped'):
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><C-o>:noh<CR>

" Resize this 'window' according to the number of lines in it (nothing to do
" with the window manager window.)
map <M--> :exe "resize ". line("$")<CR>mxgg'x

" Debug your syntax highlighting
map <M-i> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") ."> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map Q gq
let &cpo=cpo_save
unlet cpo_save

let perl_extended_vars=1
set path=.,/usr/include/,/usr/lib/perl5,*.pm,, " include Perl in path for '|gf|' and ':find' 
set backspace=2 whichwrap+=<,>,[,],h,l " backspace and cursor keys wrap to prev/next line
"set listchars=tab:>-,trail:-,eol:$
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:␣,eol:→
set fileformat=unix
set history=50
"set iskeyword=!-~,^*,^|,^\"
set ruler
set showcmd
set viminfo='20,\"50
set nowrap "Don't screen-wrap my code by default. 
set nu "line numbers
set backup " make backups
set backupdir=~/.vim/backup
set directory=~/.vim/tmp " for temp files
set wildmenu
set wildmode=list:longest,full
set showmatch " show matching brackets
set mat=5 " blink match for x 10ths of a second
set textwidth=0
set expandtab " expand tab chars to spaces by default
set tabstop=4 " tabspacing
set softtabstop=4 " 
set shiftwidth=4 " indenting 
set popt=number:y,wrap:y,syntax:n,portrait:n
set pfn=courier:h8 " The name of the font that will be used for :hardcopy
" remove octal if you don't want 017 to increment to 020 ;)
set nrformats=octal,hex,alpha " allow us to increment letters as well as numbers via  and 
" share the unnamed register with the clipboard so when you yank in vim, you can paste in some other application with the middle click, and vice versa
set clipboard+=unnamed 
set hidden " enable undo history for when you switch buffers from one file to another. 

set wiw=80 " minimal window height and width when switching.
" removed. added MiniBufExplorer from vim.org which gets awkward with this
"set wh=23

" this must appear before syntax/filetype so it can't be in .gvimrc. see :he go
"set guioptions-=m " don't show the menubar, I know all the commands already and want the realestate
set guioptions-=T " don't bother showing the toolbar either
set laststatus=2 " more room for this for (g)vim: always show the status line no matter how many windows are open

syntax on
syntax sync fromstart
" make code indenting smarter and happier
set noautoindent
set nosmartindent
set nocindent
" this works much better than the above three do. adjust as necessary
filetype plugin indent on
set formatoptions=tcrqo

" version check for these commands
if version >= 700
	setlocal spell spelllang=en_us " turn spell checking on
	"set spellfile=~/.vim/myspellfile " where to save my additional words to with 'zg'
endif

if version >= 600
	set foldenable
	set foldmethod=marker
	set fcl=all "close folds you aren't in, automatically

	colorscheme inkpot "http://www.vim.org/scripts/script.php?script_id=1143
    "was torte but then I got urxvt! 88-colors in the term! woohoo!
	"kudos to tpope in #vim who mentioned this in conjunction with my wanting
	"88-colors while using vim in screen with urxvt as my terminal
	if $TERM =~ '^screen' && &t_Co == 8 | set t_Co=256 | endif

"choose a sane encoding for terminals
"** unnecessary for vim 7
	if version < 700 
		if has("multi_byte")
			set encoding=utf-8 
			if $TERM == "linux" || $TERM_PROGRAM == "GLterm" 
				set termencoding=latin1 
			endif 
			if $TERM == "xterm" || $TERM == "xterm-color" 
				let propv = system("xprop -id $WINDOWID -f WM_LOCALE_NAME 8s ' $0' -notype WM_LOCALE_NAME") 
				if propv !~ "WM_LOCALE_NAME .*UTF.*8" 
					set termencoding=latin1 
				endif 
			endif 
		endif
	endif
endif

" from http://www.vim.org/tips/tip.php?tip_id=1380
function s:Cursor_Moved() 

  let cur_pos= winline () 

  if g:last_pos==0 
    set cul 
    let g:last_pos=cur_pos 
    return 
  endif 

let diff= g:last_pos - cur_pos 

if diff >= 1 || diff <= -1
"if diff > 1 || diff < -1 
   set cul 
  else 
   set nocul 
end 

let g:last_pos=cur_pos 
     
endfunction 

autocmd CursorMoved,CursorMovedI * call s:Cursor_Moved() 
let g:last_pos=0

" default settings for Project plugin
let g:proj_flags='imstbgc'

"whatever the colorscheme, comments from code should be grey
"hi Comment ctermfg=DarkGrey guifg=Grey60 

" attempt to properly diagnose syntax for 'correcter' commenting with EnhancedCommentify
let g:EnhCommentifyUseSyntax = "yes"

" use unicode for powerline symbols
let g:Powerline_symbols = 'unicode'

" see also :help new-filetype for additional tips and info on the following

" Automatically source in my blank html file template remotely.
":autocmd BufNewFile  *.htm	nested :0r http://www.webdragon.net/miscel/blank2.htm|normal zR
":autocmd BufNewFile  *.html	nested :0r http://www.webdragon.net/miscel/blank2.htm|normal zR

" Automatically source in my blank html file template locally.
:autocmd BufNewFile  *.htm	1r ~/madhouse/skel/site/www/index.php
:autocmd BufNewFile  *.html	1r ~/madhouse/skel/site/www/index.php
:autocmd BufNewFile  *.php	1r ~/madhouse/skel/site/www/index.php

" same for Perl, except position the cursor at the bottom ready to start typing.
" below no longer needed due to installation of vim-perl-support-5.3.2-4.fc24.noarch - sg
":autocmd BufNewFile *.pl 0r ~/.vim/skeleton.pl|normal G
:autocmd BufNewFile *.cgi 0r ~/.vim/skeleton.cgi|normal G

" automatically source in my css blank, preferred folding mappings, and
" position the cursor appropriately
:autocmd BufNewFile *.css 0r ~/madhouse/skel/site/www/res/style/site.css|$d|2

" pretend server-side-include files are html 
:au BufRead,BufNewFile *.ssi set filetype=html

" still need to pretend php files are html
" NEXT TIME, REMEMBER TO UPDATE ~/.vim/indent/*, dumbass.  *slaps self*
" 1.05 STILL there, when 1.23 was current and not even from the same author of 
" the original that came with vim 6.x but was http://www.vim.org/scripts/script.php?script_id=1120 
" HOWEVER, http://www.vim.org/scripts/script.php?script_id=346 was what came
" with vim 6 and was replaced with 1120 for 7.x. which is now far more up to date
" and modern than 346
" in the future, use the package from https://github.com/2072/PHP-Indenting-for-VIm which current install as of this writing is 1.57
:au BufRead,BufNewFile *.php set filetype=html.php syntax=php
:au BufRead,BufNewFile *.phtml set filetype=html.php syntax=php

" make sure we're using tabs to spaces in python files no matter the global setting of expandtab
:au BufRead,BufNewFile *.py set expandtab
:au BufRead,BufNewFile *.css set noexpandtab

" ignore pandoc for now
:au BufRead,BufNewFile *.markdown set filetype=markdown syntax=markdown
:au BufRead,BufNewFile *.md set filetype=markdown syntax=markdown
:au BufRead,BufNewFile *.mkdn set filetype=markdown syntax=markdown
:au BufRead,BufNewFile *.pandoc set filetype=markdown syntax=markdown

" add syntax highlighting for jQuery from http://www.vim.org/scripts/script.php?script_id=2416
:au BufRead,BufNewFile *.js set filetype=javascript.jquery

" make these highlight in all filetypes
call matchadd('Todo', '\(TODO\|FIXME\|CHANGED\|XXX\|NOTE\|DEBUG\|TBD\)')

" Disable one diff window during a three-way diff allowing you to cut out the
" noise of a three-way diff and focus on just the changes between two versions
" at a time. Inspired by Steve Losh's Splice
function! DiffToggle(window)
  " Save the cursor position and turn on diff for all windows
  let l:save_cursor = getpos('.')
  windo :diffthis
  " Turn off diff for the specified window (but keep scrollbind) and move
  " the cursor to the left-most diff window
  exe a:window . "wincmd w"
  diffoff
  set scrollbind
  set cursorbind
  exe a:window . "wincmd " . (a:window == 1 ? "l" : "h")
  " Update the diff and restore the cursor position
  diffupdate
  call setpos('.', l:save_cursor)
endfunction
" Toggle diff view on the left, center, or right windows
nmap <silent> <leader>dL :call DiffToggle(1)<cr>
nmap <silent> <leader>dC :call DiffToggle(2)<cr>
nmap <silent> <leader>dR :call DiffToggle(3)<cr>

" Now in defaults.vim
" command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" select in visual mode, press * and voila, you're searching for that phrase!
" note that this differs from the normal-mode use of * in that you can phrase-search
vmap * :<C-U>let old_reg=@"<cr>gvy/<C-R><C-R>=substitute(escape(@",'\\/.*$^~[]'),"\\n$","","")<CR><CR>:let @"=old_reg<CR>

