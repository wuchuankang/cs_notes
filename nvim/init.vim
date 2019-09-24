"配置主要参照 github.com/theniceboy/nvim

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
set scrolloff=5
set tabstop=4
set clipboard=unnamed
set cindent
set showmatch
set backspace=indent,eol,start
set shiftwidth=4
set foldmethod=indent "依据indent缩进方式折叠代码"
set foldlevel=99
" 将折叠命令改为zf，展开可以用zr，也可以zm
map zf za   
" 重新打开文件后，光标会定位在上次编的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

autocmd FileType markdown inoremap ` ``````<left><left><left>python<cr><Esc>O
autocmd FileType markdown inoremap *  ****<left><left>
"用于在文字上添加删除线
"autocmd FileType markdown inoremap ~ ~~~~<left><left>  
autocmd FileType markdown inoremap $ $$<left>
autocmd FileType markdown nmap $ h$$<cr><Esc>O
autocmd FileType markdown imap { {}<left>
autocmd FileType markdown imap <  <
autocmd FileType python inoremap ; :
autocmd FileType python imap { {}<left>
autocmd FileType python nmap <leader>' h""""""""<left><left><left><cr><Esc>O
" Open the vimrc file anytime
map <LEADER>rc :e ~/.config/nvim/init.vim<CR>

noremap j h
noremap i k
noremap k j
noremap h i
noremap H I
noremap J 7h
noremap I 5k
noremap K 5j
noremap L 7l

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
"map b :pn<CR>  "和db删除光标前的字符冲突
map n :bn<CR>
map q :bd<CR>

"将取消高亮设置map为;
nnoremap ; :noh<CR>    


map <LEADER>j <C-w>h
map <LEADER>i <C-w>k
map <LEADER>k <C-w>j
map <LEADER>l  <C-w>l



map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

"按shift+v进入visual line模式,然后输入normal A (<++>),
"下面的语句中的c4l，c是change改变的意思，想有改变4个字符，并进入insert模式
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

call plug#begin('~/.vim/plugged')
" Other visual enhancement
Plug 'nathanaelkane/vim-indent-guides'
Plug 'heavenshell/vim-pydocstring'
" markdown中用于补全表格，虽然安装，但当前没有用
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
Plug 'iamcco/mathjax-support-for-mkdp' 
Plug 'universal-ctags/ctags'
"Plug 'ludovicchabant/vim-gutentags' 
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
"Plug 'Valloric/YouCompleteMe'
" Pretty Dress
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'liuchengxu/space-vim-theme'
Plug 'connorholyday/vim-snazzy'
" ncm2 代码补全
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-jedi'
Plug 'davidhalter/jedi-vim'  "这个是最初的创造者，专门补全Python，但是我们这里用ncm2-jedi来补全，用jedi-vim各种命令跳转功能，youcompleteme 就是采用jieda不全Python
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'roxma/nvim-yarp'
" 进行多行编辑
Plug 'terryma/vim-multiple-cursors'
" 代码重构和补全
"Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" 为python提供语义高亮
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
" 是快速注释,默认已经映射过了 <leader>cc是注释，<leader>cu是取消注释
Plug 'scrooloose/nerdcommenter'
call plug#end()


" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitbelow
    ":vsp
    ":vertical resize-10
    :sp
    " 这里是在虚拟环境中的，不同的虚拟环境需要用不同的python编译器
    " 这个可以通过在不同的虚拟环境中通过 which Python 来查询路径
    :term /home/wck/.conda/envs/py36/bin/python %
  elseif &filetype == 'html'
    exec "!chromium % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc

" working on it...
map R :call CompileBuildrrr()<CR>
func! CompileBuildrrr()
  exec "w"
  if &filetype == 'vim'
    exec "source $MYVIMRC"
  elseif &filetype == 'markdown'
    exec "echo"
  endif
endfunc


" ===
" === Dress up my vim
" ===
"map <LEADER>c1 :set background=dark<CR>:colorscheme snazzy<CR>:AirlineTheme dracula<CR>
"map <LEADER>c2 :set background=light<CR>:colorscheme ayu<CR>:AirlineTheme ayu_light<CR>

set termguicolors     " enable true colors support
colorscheme snazzy
"let g:space_vim_transp_bg = 0
"set background=dark
"colorscheme space_vim_theme
let g:airline_theme='dracula'

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

" === vim-indent-guide
" ===
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig

" ===nredtree
map ff :NERDTreeToggle<CR>
let NERDTreeMapOpenExpl = ""
let NERDTreeMapUpdir = ""
let NERDTreeMapUpdirKeepOpen = "j"
let NERDTreeMapOpenSplit = ""
let NERDTreeOpenVSplit = ""
let NERDTreeMapActivateNode = "l"
let NERDTreeMapOpenInTab = "o"    "打开制定的文件
let NERDTreeMapPreview = ""
let NERDTreeMapCloseDir = "u"
let NERDTreeMapChangeRoot = "n"
" mapmenu设置后，,+a 是添加一个文件或者路径，
" ,+d是删除当前位置处的文件，进入添加或者删除操作后，不想操作，想退出，可以用ctrl+c取消
let NERDTreeMapMenu = ","   

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

"let b:ale_linters = ['pylint']
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



"========Pydocstrinh 为函数自动添加注释
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" ===
" === NCM2
" ===
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let ncm2#popup_delay = 5
let g:ncm2#matcher = "substrfuzzy"
let g:ncm2_jedi#python_version = 3
let g:ncm2#match_highlight = 'sans-serif'

"let g:jedi#auto_initialization = 1
""let g:jedi#completion_enabled = 0
""let g:jedi#auto_vim_configuration = 0
""let g:jedi#smart_auto_mapping = 0
"let g:jedi#popup_on_dot = 1
"let g:jedi#completion_command = ""
"let g:jedi#show_call_signatures = "1"
"==============================
"====================== vim-jedi
"======================
let g:jedi#completions_enabled = 0   "不使用它补全，用ncm2/jedi补全，下面注释掉的是默认值，想更改就按照github上的说明文档进行更改
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "<leader>f"
"let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
" 使用它来给变量重命名!!!
let g:jedi#rename_command = "<leader>r"  

" filetype plugin on 允许加载文件类型插件，打开此项，vim
" 会根据检测到的文件类型，在runtimepath
" 中搜索该类型的插件，其中nerdcommentor就是一个文件类型插件，它根据文件类型进行语义高亮，要想用它，那么就必须有下面的语句设置
"但是通过在nomral下，：filetype 发现，默认已经打
"filetype plugin on


" ===
" === coc
" ===
" fix the most annoying bug that coc has
"autocmd WinEnter * call timer_start(1000, { tid -> execute('unmap if')})
"silent! autocmd BufEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})
"silent! autocmd WinEnter * silent! call silent! timer_start(600, { tid -> execute('unmap if')})

"silent! au BufEnter * silent! unmap if
""au TextChangedI * GitGutter
"" Installing plugins
"let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-gitignore']
"" use <tab> for trigger completion and navigate to the next complete item
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~ '\s'
"endfunction
"inoremap <silent><expr> <Tab>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"" Useful commands
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nmap <leader>rn <Plug>(coc-rename)


"=====
" multi_cursor
" ======
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'
