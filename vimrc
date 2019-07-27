syntax on

let mapleader=" "

set smartindent
set expandtab
set ignorecase
set smartcase
set wrap
set number
set cursorline
set incsearch
set hlsearch
set showcmd
set wildmenu
set tabstop=4
set cindent
set showmatch
set backspace=indent,eol,start
set shiftwidth=4





autocmd FileType markdown inoremap ` ```
autocmd FileType markdown inoremap ** ****<Esc>F*j<CR>:noh<CR>i
autocmd FileType markdown inoremap ~~ ~~~~<Esc>F~j<CR>:noh<CR>i
autocmd FileType markdown inoremap ** ****<Esc>F*j<CR>:noh<CR>i
autocmd FileType markdown inoremap $ $$<left>
autocmd FileType markdown imap { {}<left>
autocmd FileType python imap ; :
autocmd FileType python imap { {}<left>
autocmd FileType python imap ; :
noremap j h
noremap i k
noremap k j
noremap h i
noremap J 7h
noremap I 5k
noremap K 5j
noremap L 7l
noremap ( ()<RIGHT>
noremap [ []<RIGHT>
"inoremap { {<CR>}<ESC>0


imap{ {}<ESC>h<CR><ESC>O


map ! :q!<CR>
map s <nop>
map S :w<CR>
map Q :q<CR>
map R :source $MYVIMRC<CR>
map sl :set splitright<CR>:vsplit<CR>
map sj :set nosplitright<CR>:vsplit<CR>
map si :set nosplitbelow<CR>:split<CR>
map sk :set splitbelow<CR>:split<CR>
map b :pn<CR>
map n :bn<CR>
"map 1 :$

map <LEADER>j <C-w>h
map <LEADER>i <C-w>k
map <LEADER>k <C-w>j
map <LEADER>l  <C-w>l



map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>



call plug#begin('~/.vim/plugged')

Plug 'heavenshell/vim-pydocstring'
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'universal-ctags/ctags'
"Plug 'ludovicchabant/vim-gutentags' 
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
call plug#end()

color snazzy
"=====you complete me

nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap g/ :YcmCompleter GetDoc<CR>
nnoremap gt :YcmCompleter GetType<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_use_clangd = 0
let g:ycm_python_interpreter_path = "/sur/bin/python3"
let g:ycm_python_binary_path = "/usr/bin/python3"
let g:ycm_keep_logfiles = 1
let g:ycm_log_level = 'debug'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'

" ===nredtree
map ff :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "l"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "i"
let NERDTreeMapOpenInTab = "o"
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "n"
let NERDTreeMapChangeRoot = "y"

" ===ale
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let b:ale_linters = ['pylint']
let b:ale_fixers = ['autopep8', 'yapf']

" ===
" === Taglist
" ===
nmap <silent> T  :TagbarToggle<CR>

"========ctags
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_enabled = 1
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif


"======asyncrun
"" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap f :call asyncrun#quickfix_toggle(6)<cr>


"======quickfix
nnoremap <leader>q :call QuickfixToggle()<cr>
 
let g:quickfix_is_open = 0
 
function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction


filetype plugin on
"Uncomment to override defaults:
"let g:instant_markdown_slow = 1
"let g:instant_markdown_autostart = 0
let g:instant_markdown_open_to_the_world = 1
let g:instant_markdown_allow_unsafe_content = 1
let g:instant_markdown_allow_external_content = 1
let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0

"========Pydocstrinh 为函数自动添加注释
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab



