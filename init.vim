"" Rowense

set encoding=UTF-8

call plug#begin()
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'bling/vim-airline'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'alvan/vim-closetag'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
" File Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language Client
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-highlight']
" TypeScript Highlighting
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" File Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'dracula/vim' "theme
Plug 'EdenEast/nightfox.nvim'
Plug 'projekt0n/github-nvim-theme'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'scrooloose/nerdtree' "nerdtree
Plug 'ryanoasis/vim-devicons' "icons for nerdtree
call plug#end()
"Config Section

" START General Settings
  " Line number configuration
   set number
   set relativenumber
   " Tab configuration
   set smarttab
   set cindent
   set tabstop=2
   set shiftwidth=2
   set expandtab
   " Allow mouse clicks
   set mouse=a
   " Change the escape key to jk
   inoremap jk <Esc>
   tnoremap jk <C-\><C-n>
   " Disable commenting on new line
   autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  " Set Backup
  set backup
  " Leader key
  let mapleader = " "
" END General Settings

" START FILE SEARCHING
  "<Leader>ff to allow file searching
  "CTRL+T to open it in a new tab.
  "Enter to open it in the currently selected panel.
  nnoremap <Leader>ff :FZF<CR>
  let g:fzf_action = {
    \ 'ctrl-t': 'tab split'
    \}
"END FILE SEARCHING

colorscheme duskfox

" START NERDTree Config
  let g:NERDTreeShowHidden = 1
  let g:NERDTreeMinimalUI = 1
  let g:NERDTreeIgnore = []
  let g:NERDTreeStatusline = ''

  function! OpenNERDTreeAtCurrentFile()
      " Get the path of the current file
      let l:current_file = expand('%:p:h')
      " Open NERDTree at the directory of the current file
      execute 'NERDTree' l:current_file
  endfunction

  " Automaticaly close nvim if NERDTree is only thing left open
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  " Toggle
  nnoremap <Leader>ee :NERDTreeToggle<CR>
  nnoremap <Leader>ef :call OpenNERDTreeAtCurrentFile()<CR>
  autocmd VimEnter * NERDTree
" END NERDTree Config
"
" " open new split panes to right and below
set splitright
set splitbelow

" START Keybindings for split navigation
  " Use Ctrl+hjkl to move between split/vsplit panels
  tnoremap <C-h> <C-\><C-n><C-w>h
  tnoremap <C-j> <C-\><C-n><C-w>j
  tnoremap <C-k> <C-\><C-n><C-w>k
  tnoremap <C-l> <C-\><C-n><C-w>l
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

  nnoremap ss :split<CR>
  nnoremap sv :vsplit<CR>
" END Keyboardings for split navigation

  " turn terminal to normal mode with escape
  tnoremap <Esc> <C-\><C-n>
  " start terminal in insert mode
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
  " open terminal on ctrl+n
  function! OpenTerminal()
    split term://bash
    resize 10
  endfunction
  nnoremap <c-n> :call OpenTerminal()<CR>
" END Integrated Terminal Config

" START clipboard settings
  " allow copy all lines :%y to work
  set clipboard+=unnamedplus
" END clipboard settings

"set guifont=FiraCode\ Nerd\ Font:h11
set guifont=SpaceMono\ Nerd\ Font:h13
" required if using https://github.com/bling/vim-airline
let g:airline_powerline_fonts=1

func! WordProcessor()
  " movement changes
  map j gj
  map k gk
  " formatting text
  setlocal formatoptions=1
  setlocal noexpandtab
  setlocal wrap
  setlocal linebreak
  " spelling and thesaurus
  setlocal spell spelllang=en_us
  set thesaurus+=/home/test/.vim/thesaurus/mthesaur.txt
  " complete+=s makes autocompletion search the thesaurus
  set complete+=s
endfu
com! WP call WordProcessor()

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
