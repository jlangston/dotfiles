let g:python_host_skip_check=1
" ----------------------------------------- "
" Plugin configs                            "
" ----------------------------------------- "
call plug#begin('~/.config/nvim/plugged')

"Util
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'oberblastmeister/neuron.nvim'
Plug 'alok/notational-fzf-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'mileszs/ack.vim'
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'bling/vim-airline'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'edkolev/tmuxline.vim'
Plug 'mg979/vim-visual-multi'
Plug 'phaazon/hop.nvim'
Plug 'thaerkh/vim-workspace'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'roxma/vim-tmux-clipboard'
Plug 'troydm/zoomwintab.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'lambdalisue/suda.vim'
Plug 'jmckiern/vim-venter'
Plug 'mhinz/vim-startify'

"Javascript
Plug 'jparise/vim-graphql'

" Colors
Plug 'lilydjwg/colorizer'
Plug 'jlangston/vim-hybrid'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'RRethy/vim-illuminate'
Plug 'p00f/nvim-ts-rainbow'

"Prose
" Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

"General Programming
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'onsails/lspkind-nvim'
Plug 'tzachar/compe-tabnine', { 'do': './install.sh', 'branch': 'main'  }
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'alexaandru/nvim-lspupdate', {'branch': 'main'}
Plug 'glepnir/lspsaga.nvim', {'branch': 'main'}
Plug 'liuchengxu/vista.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'mattn/emmet-vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'janko-m/vim-test'
Plug 'rcarriga/vim-ultest', {'do': ':UpdateRemotePlugins'}
Plug 'sbdchd/neoformat'
Plug 'kana/vim-textobj-user'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'metakirby5/codi.vim'
Plug 'puremourning/vimspector'


Plug 'prettier/vim-prettier', {
                  \ 'do': 'yarn install',
                  \ 'branch': 'release/1.x',
                  \ 'for': [
                  \ 'javascript',
                  \ 'typescript',
                  \ 'css',
                  \ 'less',
                  \ 'scss',
                  \ 'json',
                  \ 'graphql',
                  \ 'markdown',
                  \ 'vue',
                  \ 'lua',
                  \ 'php',
                  \ 'python',
                  \ 'ruby',
                  \ 'html',
                  \ 'eruby',
                  \ 'swift' ] }

"Git
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
" Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'rhysd/git-messenger.vim'
Plug 'pwntester/octo.nvim'

"GoLang
" Plug 'fatih/vim-go'
" Plug 'sebdah/vim-delve'

"Ruby
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }

"Varnish
" Plug 'fgsch/vim-varnish'

"Nginx
" Plug 'chr4/nginx.vim'

call plug#end()

filetype plugin indent on

colorscheme hybrid
let g:onedark_terminal_italics=1
"highlight LineNr ctermfg=darcgrey ctermbg=blacK
highlight LineNr ctermfg=darkgrey ctermbg=none
highlight NonText ctermbg=none
syntax on
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
if &term == "xterm"
      set term=xterm-256color
endif
set background=dark
if (has("termguicolors"))
      set termguicolors
      hi LineNr ctermbg=NONE guibg=NONE
      hi! Normal ctermbg=NONE guibg=NONE
endif

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set number
set mouse=a
set mousehide
set modifiable
set secure
silent! so .vimlocal

set autoindent
set clipboard+=unnamedplus  " use the clipboards of vim and win
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set softtabstop=2 tabstop=2 shiftwidth=2
set history=1000
set ttyfast
set lazyredraw
set undolevels=1000
set wildmode=longest,list
set wildmenu
set cursorline
set expandtab
set noerrorbells                " No beeps
set number                      " Show line numbers
set backspace=indent,eol,start  " Makes backspace key more powerful.
set showcmd                     " Show me what I'm typing
set noshowmode                  " Show current mode.

set noswapfile                  " Don't use swapfile
set nobackup                    " Don't create annoying backup files
set splitright                  " Split vertical windows right to the current windows
set splitbelow                  " Split horizontal windows below to the current windows
set encoding=utf8              " Set default encoding to UTF-8
set autowrite                   " Automatically save before :next, :make etc.
set autoread                    " Automatically reread changed files without asking me anything
set backupcopy=yes
if exists('g:started_by_firenvim')
      set laststatus=0
else
      set laststatus=2
endif

set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

set showmatch                   " Do not show matching brackets by flickering
set incsearch                   " Shows the match while typing
set inccommand=nosplit
set hlsearch                    " Highlight found searches
hi  Search guibg=peru guifg=wheat
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

hi htmlArg gui=italic
hi Comment gui=italic
hi Type    gui=italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic

set switchbuf=usetab,newtab     " open new buffers always in new tabs
" Stop quickfix from stealing focus
autocmd QuickFixCmdPre * let g:mybufname=bufname('%')
autocmd QuickFixCmdPost * botright copen 8 | exec bufwinnr(g:mybufname) . 'wincmd w'
" Remove trailing whitespace
nnoremap <Leader>rtw :%s/\s\+$//e<CR>
" Quickly open/reload vim
nnoremap <leader>ev :split $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>vt :VenterToggle<CR>
"Enter Command Mode with space
nmap <space> :
" Sudo save
cmap w!! w !sudo tee > /dev/null %

"Those are annoying
nmap :Q! :q!
nmap :q1 :q!
nmap :Q1 :q!
nmap :Q :q

function! SetLightTheme()
      colorscheme base16-solarized-light
      AirlineTheme sol
endfunction

nmap <Leader>cs :call SetLightTheme()<CR>


function! SetOceanTheme()
      colorscheme base16-ocean
      AirlineTheme base16_ocean
endfunction

nmap <Leader>ot :call SetOceanTheme()<CR>


function! SetClearBackground()
      hi! Normal ctermbg=NONE guibg=NONE
endfunction

nmap <Leader>cb :call SetClearBackground()<CR>

nmap <Leader>fi mzgg=G`z

"Ctrl S to save
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

" Bubble single lines
nmap <M-up> [e
nmap <M-down> ]e
" Bubble multiple lines
vmap <M-up> [egv
vmap <M-down> ]egv

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" Buffer cycle
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap <C-q> :bw<CR>

"Vimagit status
nnoremap <leader>g :Magit<CR>
nnoremap <leader>gs :MagitOnly<CR>
let g:magit_discard_untracked_do_delete=1

"Zoom WinTab
nnoremap <C-w>z :ZoomWinTabToggle<CR>

" Fix ctrl h neovim
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

vnoremap <leader>64 c<c-r>=system('base64 --decode', @")<cr><esc>

"keys
imap jk <Esc>
" map <Space> <Leader>

"Vim Test
let test#strategy = "vimux"
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>ta :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tg :TestVisit<CR>


"Emmet
let g:user_emmet_expandabbr_key = '<Tab>'
let g:user_emmet_mode='a'
let g:user_emmet_settings = {
                  \  'javascript' : {
                  \    'extends' : 'jsx',
                  \    'default_attributes' : {
                  \      'label': [{'htmlFor': ' '}],
                  \      'class': { 'className': ' '},
                  \    },
                  \  },
                  \}

function! ToggleJsxCssFt()
      if &filetype == 'javascript.jsx'
            set filetype=css
      else
            set filetype=javascript.jsx
      endif
endfunction

nnoremap <leader>et :call ToggleJsxCssFt()<cr>

"NerdTree
map <C-k>b :CHADopen<CR>
nnoremap <leader>s :ToggleWorkspace<CR>

"Vista
nmap <C-k>o :Vista!!<CR>
" nnoremap <silent> t :<C-u>Vista finder<cr>
let g:vista_default_executive = 'nvim_lsp'

" LSP Nvim
lua require'lsp_config'
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
lua require'finder'

"Completion.nvim
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
" nmap <tab> <Plug>(completion_smart_tab)
" nmap <s-tab> <Plug>(completion_smart_s_tab)
" let g:completion_enable_snippet = 'UltiSnips'

" Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
" Tree Sitter
lua require'treesitter_config'

"Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

"VimDif\
if &diff
      nnoremap <expr> <silent> cn (&diff ? "]c" : ":cnext\<CR>")
      nnoremap <expr> <silent> cn (&diff ? "]c" : ":cnext\<CR>")
      vnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
      vnoremap <expr> <silent> cp (&diff ? "[c" : ":cprev\<CR>")
      map <leader>1 :diffget LOCAL<CR>
      map <leader>2 :diffget BASE<CR>
      map <leader>3 :diffget REMOTE<CR>
endif

" Comment lines with cmd+/
map <C-/> :TComment<cr>
vmap <C-/> :TComment<cr>gv
map <M-/> :TComment<cr>
vmap <M-/> :TComment<cr>gv

" terminal 
if has('nvim')
      tnoremap <Esc> <C-\><C-n>
      tnoremap <M-[> <Esc>
      tnoremap <C-v><Esc> <Esc>
endif

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Advanced customization using autoload functions
autocmd VimEnter * command! Colors call fzf#vim#colors({'left': '15%'})

function! NumberToggle()
      if(&relativenumber == 1)
            set norelativenumber
      else
            set relativenumber
      endif
endfunc

nnoremap <leader>nt :call NumberToggle()<cr>

"let g:session_autosave = 'yes'
"let g:session_autoload = 'yes'
"let g:session_default_to_last = 1

"create line break when pressing enter
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
" nnoremap <esc>^[ <esc>^[

"Indent Lines
let g:indentLine_enabled = 1

"Vim MultiCursors
" let g:VM_sublime_mappings = 1
let g:VM_leader = '\\'
let g:VM_mouse_mappings = 1
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps["Select l"]           = '<S-Right>'       " start selecting left
let g:VM_maps["Select h"]           = '<S-Left>'        " start selecting right
let g:VM_maps["Select Cursor Down"] = '<M-C-Down>'      " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-C-Up>'        " start selecting up<Paste>
let g:VM_maps["Select All"] = '<M-C-g>'
let g:VM_persistent_registers = 1
let g:VM_overwrite_vim_registers = 1

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11

" AirLine
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='hybrid'
let g:airline#extensions#branch#enabled     = 1
let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1
let g:airline#extensions#tmuxline#enabled  = 1
let g:airline#extensions#nvimlsp#enabled = 1
" let g:airline#extensions#nvimlsp#error_symbol = 'E'
" let g:airline#extensions#nvimlsp#warning_symbol = 'W'

" Tmuxline config
let g:tmuxline_preset = {
                  \'a'    : '#S',
                  \'win'  : ['#I', '#W'],
                  \'cwin' : ['#I', '#W', '#F'],
                  \'y'    : ['%R', '%a', '%Y'],
                  \'z'    : '#H'}

"NeoFormat
nnoremap <leader>nfm :Neoformat<CR>
" Prettier
" nmap <Leader>fm :Prettier<CR>

"Common JS Libs
let g:used_javascript_libs = 'jquery,react,lodash'
"JSX
let g:jsx_ext_required = 0
" let g:tigris#enabled = 1

"ViMux
function! VimuxSlime()
      call VimuxSendText(@v)
      call VimuxSendKeys("Enter")
endfunction

"If text is selected, save it in the v buffer and send that buffer it to tmux
vmap <LocalLeader>vs "vy :call VimuxSlime()<CR>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vi :VimuxInspectRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>
" Zoom the tmux runner pane
map <Leader>vz :VimuxZoomRunner<CR>

" Typescript
" autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx


" Enable omni completion.
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_folding_disabled = 1

function! ToggleSpell()
      if !exists("g:showingSpell")
            let g:showingSpell=0
      endif

      if g:showingSpell==0
            execute "hi SpellBad cterm=underline ctermfg=red"
            let g:showingSpell=1
      else
            execute "hi clear SpellBad"
            let g:showingSpell=0
      endif
endfunction
nmap <Leader>sp :call ToggleSpell()<CR>


"RipGrep
if executable('rg')
      let g:ackprg = 'rg --vimgrep --no-heading'
endif


" example
let g:nv_search_paths = ['~/Dropbox/notes']
map <Leader>nv :NV<cr>

let g:firenvim_config = { 
                  \ 'globalSettings': {
                  \ 'alt': 'all',
                  \  },
                  \ 'localSettings': {
                  \ '.*': {
                  \ 'cmdline': 'firenvim',
                  \ 'priority': 0,
                  \ 'selector': 'textarea',
                  \ 'takeover': 'never',
                  \ },
                  \ }
                  \ }

sign define vimspectorBP text=🔴 texthl=Normal
sign define vimspectorBPDisabled text=🔵 texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad

let g:vimspector_enable_mappings = 'HUMAN'

" au BufWrite *.html.erb :Autoformat
" au BufReadPost *.html set filetype=html.eruby
" au BufReadPost *.plush set filetype=html.eruby
" au BufReadPost *.md set filetype=markdown.eruby
" au BufReadPost *.toml set filetype=toml.markdown.eruby
