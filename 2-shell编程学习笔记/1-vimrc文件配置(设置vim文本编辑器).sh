if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
						" than 50 lines of registers

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" 关闭兼容模式
set nocompatible

" 设置历史记录步数 
set history=100

" 开启相关插件
filetype plugin on
filetype on
filetype indent on

" 当文件在外部修改时,自动更新文件
set autoread

" 激活鼠标使用
set mouse=a

" 开启语法
syntax enable

"设置字体
"set guifont=dejaVu\ Sans\ MONO\ 10
"
"设置颜色
"colorscheme desert

" 高亮显示当前行
set cursorline
hi cursorline guibg=#00ff00
hi CursorColumn guibg=#00ff00

set nofen

" 激活折叠功能
set foldenable

set fdl=0

" 6 种折叠方法
" manual   手工定义折叠
" indent	更多的缩进表示更高级别的折叠
" expr		用表达式来定义折叠
" syntax	用语法高亮来定义折叠
" diff		对没有更改的文本进行折叠
" marker	对文中的标志进行折叠
set foldmethod=manual

" 设置折叠区的宽度如果不为0
" 则在屏幕左侧显示一个折叠标识列
" 分别用'-'和'+'来表示打开和关闭的折叠
set foldcolumn=1

" 设置折叠层数
setlocal foldlevel=3

" 设置自动关闭折叠 
set foldclose=all

" 用空格键来代替zo和zc快捷键来实现开关折叠
" zo 打开折叠
" zc 关闭折叠
" zf 创建折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

" 使用空格替换Tab
set expandtab 

" 设置多有Tab和缩进为4个空格
set tabstop=4

" 设定 << 和 >> 命令移动时的宽度为4
set shiftwidth=4

" 使得按空格键时可以一次删掉4个空格
set softtabstop=4

set smarttab

" 缩进和自动缩进
set ai

" 智能缩进
set si

" 自动换行
set wrap

" 设置软宽度
set sw=4

" 这是标尺
set ruler

set wildmenu

" 设置命令行的高度
set cmdheight=1

" 显示行数
set  nu

" 
set lz

" 设置退格
set backspace=eol,start,indent

" 
set whichwrap+=<,>,h,l

" 设置魔术
set magic

" 关闭错误信息响铃
set noerrorbells

set novisualbell

" 显示匹配的括号
set showmatch

" 
set mat=2

" 搜索时不区分大小写
set ignorecase

" 设置编码
set encoding=utf-8

" 设置文件编码
set fileencodings=utf-8

" 设置终端编码
set termencoding=utf-8

" 开启新行时使用智能自动缩进
set smartindent

set cin

set showmatch

" 隐藏工具栏
set guioptions-=T

" 隐藏菜单栏
set guioptions-=m

" 置空错误提示铃声终端代码
set vb t_vb=

" 显示状态栏(默认值1,表示无法显示状态栏)
set laststatus=2

" 粘贴不换行问题的解决方法
set pastetoggle=<F9>

" 设置背景色
set background=dark

" 设置高亮相关
highlight Search ctermbg=black  ctermfg=white  guifg=white  guibg=black

" 在shell脚本的开头自动增加解释器及作者等版权信息
"autocmd BufNewFile *.py,*.cc,*.sh,*.java exec ":call SetTitle()"
"func SetTitle()
"  if expand("%:e")== 'sh'
"	 call setline(1, "#!/bin/bash")
"	 call setline(2, "#Author:oldboy")
"	 call setline(3, "#Blog:http://oldboy.blog.51cto.com")
"	 call setline(4, "#Time:".strftime("%F  %T"))
"	 call setline(5, "#Name:".expand("%"))
"	 call setline(6, "#Version:V1.0")
"	 call setline(7, "#Description:This is a test script.")
"  endif
"endfunc


