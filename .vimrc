" modifications for vundle:
" https://github.com/gmarik/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'JuliaLang/julia-vim'
Plugin 'wting/rust.vim'


" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

let g:syntastic_c_compiler = "clang"
let g:syntastic_c_check_header = 1
let g:syntastic_c_no_include_search = 1
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_c_compiler_options = "-Wall -I$HOME/work/soft/mpich/include -I${HOME}/work/soft/snappy-master/include -I${HOME}/work/soft/mercury/include"
let g:syntastic_cxx_compiler_options = "-Wall -I$HOME/work/soft/mpich/include -I${HOME}/work/soft/snappy-master/include -I${HOME}/work/soft/mercury/include"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_c_remove_include_errors = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
" If we are in the mpich directory, add the correct include directories
if getcwd() =~ 'mpich$'
	let g:syntastic_c_include_dirs = [
            \ 'src/include',
            \ 'src/mpi/romio/adio/include',
            \ 'src/mpid/ch3/include',
            \ 'src/mpid/ch3/channels/nemesis/include',
            \ 'src/mpid/ch3/channels/nemesis/utils/monitor',
            \ 'src/mpid/ch3/channels/sock/include',
            \ 'src/mpid/common/datatype',
            \ 'src/mpid/common/sched',
            \ 'src/mpid/common/thread',
            \ 'src/util/wrappers',
            \ 'test/mpi/include/',
            \ ]
elseif getcwd() =~ 'data_structures$'
	let g:syntastic_c_include_dirs = [
	    \ '/home/robl/work/soft/data_structures/include',
	    \ 'include',
	    \ 'src',
	    \ '.',
	    \ ]
else
	let g:syntastic_c_include_dirs = [
            \ 'include',
	    \ 'src',
            \ '.',
            \ ]
endif
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	1999 Sep 09
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set bg=dark
"set ruler		" show the cursor position all the time
set wrap
set sm
set notbs		" can't sort the tags the right way, so i give up
set nohls
set ignorecase
set smartcase

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq


" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78
 autocmd BufRead *.java set tw=78 sw=4 ts=4

 autocmd BufRead mutt-*-*-* so ${HOME}/.vimrc-mutt
 " source ${HOME}/.vimrc-cscope not quite working yet

 " let's try this:  in mutt, i want a text width of 70:
" autocmd BufRead mutt-*-*-* set tw=70 
 " removes quotes sigs (with -- or string of == or __ as delimiter)
" autocmd BufRead mutt-*-*-* normal :g/^> *[-_=]\{2,} *$/,/^$/-1dgg/^$
 " macro for ROT13
" autocmd BufRead mutt-*-*-* noremap ,rot :.,/-- $/!tr A-Za-z N-ZA-Mn-za-m
" autocmd BufRead mutt-*-*-* noremap ,srot /^Subjectdw:.!tr A-Za-z N-ZA-Mn-za-m0P
" autocmd BufRead mutt-*-*-* noremap ,att 1G/^$<CR>iAttach:<ESC>:r!ls
 
" autocmd BufRead mutt-*-*-* noremap ,rot :0:/^$/,/-- $/!tr A-Za-z N-ZA-Mn-za-m/^Subject:dw:.!tr A-Za-z N-ZA-Mn-za-m0P 
 
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp,java  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,:// ts=8 sts=4 sw=4 noexpandtab
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  " set binary mode before reading the file
  autocmd BufReadPre,FileReadPre	*.gz,*.bz2 set bin
  autocmd BufReadPost,FileReadPost	*.gz call GZIP_read("gunzip")
  autocmd BufReadPost,FileReadPost	*.bz2 call GZIP_read("bunzip2")
  autocmd BufWritePost,FileWritePost	*.gz call GZIP_write("gzip")
  autocmd BufWritePost,FileWritePost	*.bz2 call GZIP_write("bzip2")
  autocmd FileAppendPre			*.gz call GZIP_appre("gunzip")
  autocmd FileAppendPre			*.bz2 call GZIP_appre("bunzip2")
  autocmd FileAppendPost		*.gz call GZIP_write("gzip")
  autocmd FileAppendPost		*.bz2 call GZIP_write("bzip2")

  " After reading compressed file: Uncompress text in buffer with "cmd"
  fun! GZIP_read(cmd)
    let ch_save = &ch
    set ch=2
    execute "'[,']!" . a:cmd
    set nobin
    let &ch = ch_save
    execute ":doautocmd BufReadPost " . expand("%:r")
  endfun

  " After writing compressed file: Compress written file with "cmd"
  fun! GZIP_write(cmd)
    if rename(expand("<afile>"), expand("<afile>:r")) == 0
      execute "!" . a:cmd . " <afile>:r"
    endif
  endfun

  " Before appending to compressed file: Uncompress file with "cmd"
  fun! GZIP_appre(cmd)
    execute "!" . a:cmd . " <afile>"
    call rename(expand("<afile>:r"), expand("<afile>"))
  endfun

 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")
if version >=600
    " speed up startup when ssh'd into a host (X forwarding blah)
    if $SSH_CLIENT != "" || $SSH_TTY != ""
        set cb=exclude:.*
    endif
endif

if version >= 508
  set pastetoggle=<F9>      " toggle :paste setting
endif

" with the firefox extension _it's all text_, spawn a vim session for any
" textareak.  just need to help it a bit with file types
" stored Wikipedia.vim in ~/.vim/syntax
au BufRead,BufNewFile *itsalltext/wiki*.txt setfiletype Wikipedia
au BufRead,BufNewFile *itsalltext/trac*.txt setfiletype Wikipedia

if version >=700
  " it just got too annoying to have this on by default
  " map <F11> :set spell spelllang=en_us<CR>
endif

filetype indent on  
filetype plugin on


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


