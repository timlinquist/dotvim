" Load plugins via pathogen
call pathogen#runtime_append_all_bundles()

"BASIC OPTIONS
set nocompatible
set wildmenu
set wildignore+=*.png,*.jpg,*.gif,*.ai,*.jpeg,*.psd,*.swp,*.jar,*.zip,*.gem,.DS_Store,log/**,tmp/**,coverage/**,rdoc/**
set list

"KEY BINDINGS
let mapleader=',' " set leader to ,

" format paragraphs (72 columns)
map ^^ {!}par w72qrg<CR>

" one-stroke window maximizing
map <C-H> <C-W>h<C-W><BAR>
map <C-L> <C-W>l<C-W><BAR>
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_

" shortcut to strip trailing whitespace
" map <leader>s :s/\s\+$//g<CR>
map <leader>s :%s/\s\+$//

" retab the document (tabs to spaces)
nmap <silent> <leader><S-t> :retab!<CR>

",r to check Ruby syntax on current buffer
map <silent> <Leader>r :!ruby -c %:p<CR>

" globbed file opening
nmap <leader>g :e **/
cmap <leader>g **/

"PLUGIN OPTIONS
runtime macros/matchit.vim

"bufexplorer
let g:bufExplorerDetailedHelp=1     " show full help text by default
"let g:bufExplorerShowRelativePath=1 " use relative paths
let g:bufExplorerShowUnlisted=1     " display unlisted buffers

let NERDCreateDefaultMappings=0 " disable default mappings
let NERDMenuMode=0              " disable menu
let NERDSpaceDelims=1           " place spaces after comment chars
let NERDDefaultNesting=0        " don't recomment commented lines

map <leader>cc <plug>NERDCommenterToggle
map <leader>cC <plug>NERDCommenterSexy
map <leader>cu <plug>NERDCommenterUncomment

"Tabular
" sets ,a to align = and => lines
map <leader>a :Tabularize /=>\?<cr>

"Taglist
map <leader>t :TlistToggle<cr>

"WINDOW OPTIONS
colorscheme Vividchalk
set background=dark " use colors suitable for dark backgrounds
set ruler          " shows cursor position in the lower right
set showcmd        " shows incomplete command to the left of the ruler
set winminheight=0 " allow windows to be 0 lines tall
set winminwidth=0  " allow windows to be 0 lines wide
set laststatus=2   " always show statusline

let stl = "%<"

" buffer number
let stl .= "%n: "

" truncated filename
let stl .= "%-.60f "

let stl .= "%{&filetype} "

" is preview window
let stl .= "%10w"

" git status
let stl .= "%{fugitive#statusline()} "

" set highlight to ErrorMsg for yelling
let stl .= "%="
let stl .= "%#ErrorMsg#"

" yell at me if dirty
let stl .= "%{&modified > 0 ? '-dirty-' : ''}"
let stl .= "%{&modified == 1 && &modifiable == 0 ? ' ' : ''}"

" yell at me if readonly
let stl .= "%{&modifiable == 0 ? 'readonly' : ''}"

" reset highlight
let stl .= "%*"

" column:line/max
let stl .= " %c:"
let stl .= "%l/%L %P"

set statusline=%!stl

"EDITING OPTIONS
syntax on
set number      " line numbers
set showbreak=+ " display a + at the beginning of a wrapped line
set showmatch   " flash the matching bracket on inserting a )]} etc

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set softtabstop=2 " most of the time, we want a softtabstop of 2
set tabstop=2     " show tabs with 2 spaces
set shiftwidth=2  " shift by 2 spaces when using >> and <<, etc
set expandtab     " no tabs

" Using autocmd for this allows it to be reset every time you open a
" file, which keeps overrides from being persistent
autocmd FileType * set softtabstop=2 shiftwidth=2 tabstop=2 expandtab

set list                     " show whitespace
set listchars=tab:»·,trail:· " show tabs and trailing spaces
set listchars+=extends:»     " show a » when a line goes off the right edge of the screen
set listchars+=precedes:«    " show a « when a line goes off the left edge of the screen

"FOLDING OPTIONS
set foldmethod=indent  " really the only way that makes sense
set foldlevelstart=99  " open all folds by default
set foldignore=        " don't try to be clever

"SEARCH OPTIONS
set ignorecase " makes search patterns case-insensitive by default
set smartcase  " overrides ignorecase when the pattern contains upper-case characters
set incsearch

"SWAP & UNDO OPTIONS
" global swapfile directory
set directory=~/.vim/swapfiles,/var/tmp,/tmp,

" persistent undo
set undofile
set undodir=/var/tmp,/tmp,

"FILETYPE OPTIONS
" use filetype plugins to determine indent settings
filetype plugin indent on

" Python settings
autocmd FileType python setlocal tabstop=8 expandtab shiftwidth=4 softtabstop=4

" ruby and yaml indentation
autocmd FileType ruby,rdoc,cucumber,yaml,html,eruby,handlebars set softtabstop=2 shiftwidth=2 tabstop=2
autocmd BufNewFile,BufRead Gemfile     setfiletype ruby
autocmd BufNewFile,BufRead config.ru   setfiletype ruby
autocmd BufNewFile,BufRead *.thor      setfiletype ruby

" Templating languages
autocmd BufNewFile,BufRead *.jst       setfiletype eruby.html
autocmd BufNewFile,BufRead *.handlebars setfiletype handlebars

" markdown files
autocmd BufRead,BufNewFile *.mkd,*.markdown,*.md,*.mdown,*.mkdn set softtabstop=4 shiftwidth=4 tabstop=4
autocmd BufRead,BufNewFile *.mkd,*.markdown,*.md,*.mdown,*.mkdn set noexpandtab

" set filetype on config files
autocmd BufNewFile,BufRead ~/.vim/*  setfiletype vim

" set the snippets for rails/ruby projects
autocmd vimenter * call s:SetupSnippets()
function! s:SetupSnippets()
  call ExtractSnips("~/.vim/snippets/html", "eruby")
  call ExtractSnips("~/.vim/snippets/html", "xhtml")
  call ExtractSnips("~/.vim/snippets/html", "php")
endfunction

"GUI OPTIONS
if has("gui_running")
  set mouse=a
  set guifont=Monaco:h14 " Inconsolata, 16pt high

  " set default window size
  set columns=180
  set lines=62

  " GUI option string.  Values:
  "   c: don't pop up windows; use the console for dialog boxes and such
  "   e: use GUI tab bar instead of text tab bar
  set guioptions=ce

  " Set GUI Cursor Options
  highlight Cursor guifg=khaki guibg=Goldenrod3
  highlight iCursor guifg=khaki guibg=Goldenrod3

  " Highlight the cursor line
  set cursorline
endif
