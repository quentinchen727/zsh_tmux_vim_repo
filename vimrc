" au BufNewFile *.html 0r ~/skeleton.html
" Settings {{{
" Customized configuration
let mapleader = "-"
" Local leader configuration related to some file types
" let maplocalleader = "-"

" Switch syntax highlighting on, when the terminal has colors
syntax on

" Use vim, not vi api
set nocompatible

" No backup files
set nobackup

" No write backup
set nowritebackup

" No swap file
set noswapfile

" Command history
set history=100

" Always show cursor
set ruler

" Show incomplete commands
set showcmd

" Incremental searching (search as you type)
set incsearch

" Highlight search matches
set hlsearch

" Ignore case in search
set smartcase

" Make sure any searches /searchPhrase doesn't need the \c escape character
set ignorecase

" A buffer is marked as ‘hidden’ if it has unsaved changes, and it is not currently loaded in a window
" if you try and quit Vim while there are hidden buffers, you will raise an error:
" E162: No write since last change for buffer “a.txt”
set hidden

" Turn word wrap off
set nowrap

" Set sidescroll for lines wider than window
set sidescroll=1

" Allow backspace to delete end of line, indent and start of line characters
set backspace=indent,eol,start

" Convert tabs to spaces
set expandtab

" Set tab size in spaces (this is for manual indenting)
set tabstop=4

" The number of spaces inserted for a tab (used for auto indenting)
set shiftwidth=4

" Turn on line numbers and relative numbers
set number
" set relativenumber

" Highlight tailing whitespace
" See issue: https://github.com/Integralist/ProVim/issues/4
set list listchars=tab:\ \ ,trail:·

" Get rid of the delay when pressing O (for example)
" http://stackoverflow.com/questions/2158516/vim-delay-before-o-opens-a-new-line
set timeout timeoutlen=1000 ttimeoutlen=100

" Always show status bar
set laststatus=2

" Set the status line to something useful
set statusline=%f\ %=L:%l/%L\ %c\ (%p%%)

" Hide the toolbar
set guioptions-=T

" UTF encoding
set encoding=utf-8

" Autoload files that have changed outside of vim
set autoread

" Use system clipboard
" http://stackoverflow.com/questions/8134647/copy-and-paste-in-vim-via-keyboard-between-different-mac-terminals
set clipboard+=unnamed

" Don't show intro
set shortmess+=I

" Better splits (new windows appear below and to the right)
set splitbelow
set splitright

" Highlight the current line
set cursorline

" Ensure Vim doesn't beep at you every time you make a mistype
set visualbell

" Visual autocomplete for command menu (e.g. :e ~/path/to/file)
set wildmenu

" redraw only when we need to (i.e. don't redraw when executing a macro)
set lazyredraw

" highlight a matching [{()}] when cursor is placed on start/end character
set showmatch

" Set built-in file system explorer to use layout similar to the NERDTree plugin
let g:netrw_liststyle=3

" Always highlight column 80 so it's easier to see where
" cutoff appears on longer screens
augroup highlight_80_col
  autocmd!
  autocmd BufWinEnter * highlight ColorColumn ctermbg=darkred
augroup END
set colorcolumn=80
set t_Co=256

" Hiding files matching .ignore pattern
"let g:netrw_list_hide=netrw_gitignore#Hide()

" Simple Python fold setting
" augroup python_fold
  " autocmd!
  " autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
  " autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" augroup END
" }}}

" Plugins {{{
"execute pathogen#infect()
" filetype plugin indent on " required by Pathogen Plugin Manager
"execute pathogen#helptags()
"
"Specify a directory for plugins
call plug#begin('~/.vim/bundle')
" nnoremap  <leader>q :q<cr>

"Colorsheme
Plug 'morhetz/gruvbox'
Plug 'jnurmine/Zenburn'

" Vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" let g:airline_theme = 'tomorrow'

" Nerdtree
Plug 'scrooloose/nerdtree'
let NERDTReeIgnore = ['\.pyc$', '\~$'] "ignore files in NERDTree

" Python simple fold
Plug 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview = 1

" Auto-indentation fix for python
Plug 'vim-scripts/indentpython.vim'

" Auto-complete; YCM needs extra installation to work in cgwin.
Plug 'Valloric/YouCompleteMe'

let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_python_binary_path = '/usr/bin/python'
let g:ycm_python_binary_path = '/usr/bin/python3'
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>

" Syntax checking/highlighting and PEP8 check
Plug 'scrooloose/syntastic'
Plug 'nvie/vim-flake8'

" Recommended setting in offical docs
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Set vimscript lint
let g:syntastic_vim_checker = ['vint']

" Super searching
Plug 'kien/ctrlp.vim'

" Git integration
Plug 'tpope/vim-fugitive'

" Commentary
Plug 'tpope/vim-commentary'

" Quick mapping
Plug 'tpope/vim-unimpaired'

" Ack search faster than grep
Plug 'mileszs/ack.vim'

" ZoomWin
Plug 'vim-scripts/ZoomWin'

" Javascript configuration
" Nicer look for javascript: syntax + higlight + indent
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'nathanaelkane/vim-indent-guides'
" Add delimter automatically
Plug 'Raimondi/delimitMate'
let delimitMate_expand_cr = 1
" Extra completion for javascript
Plug 'marijnh/tern_for_vim'

" html or xml surrounding plugin
Plug 'tpope/vim-surround'

" html css hi-speed coding
Plug 'mattn/emmet-vim'

" vim session plugin
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" Initialize plugin system
call plug#end()

" Theme
" if has('gui_running')
if &term =~ 'linux'
  colorscheme zenburn
else
  set background=dark
  colorscheme gruvbox
endif

" CtrlP
map <leader>t <C-p>
map <leader>y :CtrlPBuffer<cr>
let g:ctrlp_show_hidden=1
let g:ctrlp_working_path_mode=0
let g:ctrlp_max_height=30
let g:ctrlp_arg_map=1

" CtrlP -> override <C-o> to provide options for how to open files
let g:ctrlp_arg_map = 1

" CtrlP -> files matched are ignored when expanding wildcards
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*.,*/.DS_Store

" CtrlP -> use Ag for searching instead of VimScript
" (might not work with ctrlp_show_hidden and ctrlp_custom_ignore)
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" CtrlP -> directories to ignore when fuzzy finding
let g:ctrlp_custom_ignore = '\v[\/]((node_modules)|\.(git|svn|grunt|sass-cache))$'

" Ack (uses Ag behind the scenes)
let g:ackprg = 'ag --nogroup --nocolor --column'

" Airline (status line)
" let g:airline_powerline_fonts = 1

" Gist authorisation settings
let g:github_user = $GITHUB_USER
let g:github_token = $GITHUB_TOKEN
let g:gist_detect_filetype = 1
let g:gist_open_browser_after_post = 1
" Related plugins:
" https://github.com/mattn/webapi-vim
" https://github.com/vim-scripts/Gist.vim
" https://github.com/tpope/vim-fugitive

" HTML generation using 'emmet-vim'
" NORMAL mode Ctrl+y then , <C-y,>

" Git gutter
let g:gitgutter_enabled = 1
let g:gitgutter_eager = 0
let g:gitgutter_sign_column_always = 1
highlight clear SignColumn

" Map NERDTree toggle
map <leader>' :NERDTreeToggle<cr>

" Tabularize
" map <Leader>e :Tabularize /=<cr>
" map <Leader>c :Tabularize /:<cr>
" map <Leader>es :Tabularize /=\zs<cr>
" map <Leader>cs :Tabularize /:\zs<cr>

" Camel Case Motion (for dealing with programming code)
" map <silent> w <Plug>CamelCaseMotion_w
" map <silent> b <Plug>CamelCaseMotion_b
" map <silent> e <Plug>CamelCaseMotion_e
" sunmap w
" sunmap b
" sunmap e
" }}}

" Mappings {{{
" Notes...
"
" :map     j gg (j will be mapped to gg)
" :map     Q j  (Q will also be mapped to gg, because j will be expanded -> recursive mapping)
" :noremap W j  (W will be mapped to j not to gg, because j will not be expanded -> non recursive)
"
" These mappings work in all modes. To have mappings work in only specific
" modes then denote the mapping with the mode character.
"
" e.g.
" to map something in just NORMAL mode use :nmap or :nnoremap
" to map something in just VISUAL mode use :vmap or :vnoremap

" Always use no-recursive key mapping

" YouCompleteMe subcommand mapping
nnoremap <leader>d :YcmCompleter GoTo<cr>
nnoremap <leader>r :YcmCompleter GoToReferences<cr>
nnoremap <leader>f :YcmCompleter RefactorRename<space>

" window mapping
nnoremap - <C-w>-
nnoremap + <C-w>+
nnoremap 7 :vertical resize -1<cr>
nnoremap 8 :vertical resize +1<cr>
nnoremap <F5> :b#<cr>

" Syntastic mapping
nnoremap <F3> :SyntasticCheck<cr>
nnoremap <F2> :SyntasticToggleMode<cr>

" insert to the end
inoremap <C-e> <esc>A

" Open .vimrc file for editing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source .vimrc file to make it take into effect
nnoremap <leader>sv :source $MYVIMRC<cr>

" Change into uppercase in insert mode
inoremap <leader>u <esc>viwUea

" Change into uppercase in normal mode
nnoremap <leader>u viwUw

" Add double quotes to a word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>e

" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" Force map jk to esc to save some effort for left finger
inoremap jk <esc>
inoremap <esc> <nop>

" toggle foldcolumn
" nnoremap <leader>f :call FolderColumnToggle()<cr>

" function! FolderColumnToggle()
"   if &foldcolumn
"     setlocal foldcolumn=0
"   else
"     setlocal foldcolumn=4
"   endif
" endfunction

" Toggle Quickfix windows
nnoremap <leader>q :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
  else
    copen
    let g:quickfix_is_open = 1
  endif
endfunction

" Abbreviation
iabbrev ssig -- <cr>Qin Chen<cr>qinche@cisco.com
iabbrev fnc function

" Operator-pending mappings: choose paremeters/until return
onoremap p i(

" Shortcut to serach and replace
" nnoremap ;; :%s:::g<Left><Left><Left>
" nnoremap ;' :%s:::gc<Left><Left><Left><Left>

" Shortcut for commandline mapping
cnoremap ;\ \(\)<Left><Left>

" Split navigations
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h

" Enable folding with the spacebar
nnoremap <space> za

" nnoremap  <leader>q :q<cr>

" Clear search buffer
:nnoremap § :nohlsearch<cr>

" Command to use sudo when needed
cmap w!! %!sudo tee > /dev/null %

" File System Explorer (in horizontal split)
map <leader>. :Sexplore<cr>

" Buffers
map <leader>yt :ls<cr>

" Buffers (runs the delete buffer command on all open buffers)
map <leader>yd :bufdo bd<cr>

" Make handling vertical/linear Vim windows easier
map <leader>w- <C-W>- " decrement height
map <leader>w+ <C-W>+ " increment height
map <leader>w] <C-W>_ " maximize height
map <leader>w[ <C-W>= " equalize all windows

" Handling horizontal Vim windows doesn't appear to be possible.
" Attempting to map <C-W> < and > didn't work
" Same with mapping <C-W>|

" Make splitting Vim windows easier
nnoremap <leader>s <C-W>s
nnoremap <leader>v <C-W>v
" Split open a recent file
" nnoremap  <leader>v :execute "rightbelow vsplit " . bufname("#")<cr>


" Running Tests...
" See also <https://gist.github.com/8114940>

" " Run currently open RSpec test file
" map <Leader>rf :w<cr>:!rspec % --format nested<cr>

" " Run current RSpec test
" " RSpec is clever enough to work out the test to run if the cursor is on any line within the test
" map <Leader>rl :w<cr>:exe "!rspec %" . ":" . line(".")<cr>

" " Run all RSpec tests
" map <Leader>rt :w<cr>:!rspec --format nested<cr>

" " Run currently open cucumber feature file
" map <Leader>cf :w<cr>:!cucumber %<cr>

" " Run current cucumber scenario
" map <Leader>cl :w<cr>:exe "!cucumber %" . ":" . line(".")<cr>

" " Run all cucumber feature files
" map <Leader>ct :w<cr>:!cucumber<cr>

" Tmux style window selection
map <Leader>ws :ChooseWin<cr>

" gruvvox solution to address cursor problem in search
if &term != 'linux'
  nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
  nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
  nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

  nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
  nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
  nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
endif
" }}}

" Commands {{{
" jump to last cursor
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

fun! StripTrailingWhitespace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

" file formats
augroup file_format
  autocmd!
  autocmd Filetype gitcommit setlocal spell textwidth=72
  autocmd Filetype markdown setlocal wrap linebreak nolist textwidth=0 wrapmargin=0 " http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
  autocmd FileType sh,cucumber,ruby,yaml,zsh,vim,vimrc,html setlocal shiftwidth=2 tabstop=2 expandtab
augroup END

" specify syntax highlighting for specific files
" autocmd Bufread,BufNewFile *.spv set filetype=php
" autocmd Bufread,BufNewFile *.md set filetype=markdown " Vim interprets .md as 'modula2' otherwise, see :set filetype?

" Highlight words to avoid in tech writing
" http://css-tricks.com/words-avoid-educational-writing/
" highlight TechWordsToAvoid ctermbg=red ctermfg=white
" match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however\|so,\|easy/
" autocmd BufWinEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
" autocmd InsertEnter * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
" autocmd InsertLeave * match TechWordsToAvoid /\cobviously\|basically\|simply\|of\scourse\|clearly\|just\|everyone\sknows\|however,\|so,\|easy/
" autocmd BufWinLeave * call clearmatches()

" Create a 'scratch buffer' which is a temporary buffer Vim wont ask to save
" http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
    if part[0] =~ '\v[%#<]'
      let expanded_part = fnameescape(expand(part))
      let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
    endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" open all folds when opening a new buffer
augroup auto_fold
  autocmd!
  autocmd FileType vim,zsh,sh,conf setlocal foldmethod=marker
  autocmd BufRead * normal zR
augroup END

" " Rainbow parenthesis always on!
" if exists(':RainbowParenthesesToggle')
"   autocmd VimEnter * RainbowParenthesesToggle
"   autocmd Syntax * RainbowParenthesesLoadRound
"   autocmd Syntax * RainbowParenthesesLoadSquare
"   autocmd Syntax * RainbowParenthesesLoadBraces
" endif

" Reset spelling colours when reading a new buffer
" This works around an issue where the colorscheme is changed by .local.vimrc
fun! SetSpellingColors()
  highlight SpellBad cterm=bold ctermfg=white ctermbg=red
  highlight SpellCap cterm=bold ctermfg=red ctermbg=white
endfun
autocmd BufWinEnter * call SetSpellingColors()
autocmd BufNewFile * call SetSpellingColors()
autocmd BufRead * call SetSpellingColors()
autocmd InsertEnter * call SetSpellingColors()
autocmd InsertLeave * call SetSpellingColors()

" Change colourscheme when diffing
fun! SetDiffColors()
  highlight DiffAdd    cterm=bold ctermfg=white ctermbg=DarkGreen
  highlight DiffDelete cterm=bold ctermfg=white ctermbg=DarkGrey
  highlight DiffChange cterm=bold ctermfg=white ctermbg=DarkBlue
  highlight DiffText   cterm=bold ctermfg=white ctermbg=DarkRed
endfun
autocmd filterwritepre * call SetDiffColors()

" sudo to write a system file
command! W w !sudo tee % > /dev/null

" Remember the list of my latest buffers. Somehow it does not work in the
" setting section. Maybe it is negated by some other settings
" set viminfo^=%

" }}}
