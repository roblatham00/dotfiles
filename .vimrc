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
  autocmd FileType c,cpp,java  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
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
  set pastetoggle=<F10>      " toggle :paste setting
endif

" with the firefox extension _it's all text_, spawn a vim session for any
" textareak.  just need to help it a bit with file types
" stored Wikipedia.vim in ~/.vim/syntax
au BufRead,BufNewFile *itsalltext/wiki*.txt setfiletype Wikipedia
au BufRead,BufNewFile *itsalltext/trac*.txt setfiletype Wikipedia

if version >=700
  " it just got too annoying to have this on by default
  map <F11> :set spell spelllang=en_us<CR>
endif
