## shell
- shell 脚本执行：  
    可以通过 `source` 、 `sh` 、 `.` 或者相对路径来运行，其中 `source` 和 `.` 的意思是相同的，都是在当前 `shell` 中执行，并且不需要 shell 脚本文件具有可执行权限， `sh` 和 相对路径来运行shell脚本文件，都是在当前shell 进程下开辟子进程进行执行，其中相对路径执行需要shell 脚本具有可执行权限。使其具有可执行权限的通过：
    ```cpp
    chmod 755 xxx    // xxx 是shell 脚本程序
    ```
- 变量  
    1. 本地变量： 用户自定义变量，**变量名用小写字母**， 只在当前shell 中可用，作用域是当前shell， 可把shell当做是 c语言中的函数，而本地变量就是函数中定义的临时变量。在子shell中不可以用；  
    2. 环境变量： **变量名用大写**, 有系统默认的环境变量(如 `PATH`)，也可以通过 `export` 将本地变量定义为环境变量，像 c 语言中的全局变量。在子shell 中也可以使用。  
    3. 位置参数变量:  
        - $n: $0 代表命令本身， $1-$9 代表第1到第9个参数
        - $*: 代表命令中所有的参数，并且将它们看成一个整体  
        - $@: 也是所有的参数，但是把它们分开来看，相当与存储在一个数组里，用 `for` 循环可以遍历
        - $#: 代表命令行中参数的个数
    4. 系统预定义的变量:
        - $?: 代表上一次执行的返回状态， 如果这个变量值为0，证明上一个命令执行正确
    5. 补充说明 `export` ：为何叫 `export` ？那是因为用户自定义的变量只有当前 `shell` 可用，要想子 `shell` 可用，就要将当前的变量导出本 `shell` 之外，像 `c` 语言中的 `extern` 关键字。

- 输入输出重定向  
  - >: 以覆盖的方式将命令的输出添加到文件中，比如 date > a.txt，如果 a.txt 中有其他的东西都会被覆盖掉
  - >>: 以追加的方式将命令的输出添加到文件中
  - &>: 上面的两种，只有当命令本身是正确的时候，才会重定向，当我们shell 编程的时候，有时不知道命令是不是正确，如果不正确，也想重定向到日志中，以备查看解决问题，这个时候就可以使用 &>， 这个是覆盖
  - &>>: 是追加的方式添加到文件中

- 命令的顺序
    - ； ： 多个命令顺序执行，某个命令执行错误，不影响后面的命令的执行
    - && ： 逻辑与，这个逻辑不像 `c` 语言中的 `与`, 后者是所有用 `&&` 并列的条件都满足才执行，而在 `sehll` 中，只要前者命令执行正确，后面的命令才执行，否则后面的命令不执行；
    - || ： 逻辑或，当前者命令执行正确，后面的不执行；否则后面的执行。  

- test 命令([] / [[]])  
    [参见test命令详解](http://c.biancheng.net/view/2742.html)  
    [参见shell [[]]详解](http://c.biancheng.net/view/2751.html)

- .zshrc 详解
```sh
# $- 是 shell 的标志，如果shell 是交互式的，那么 $- 所代表的一串字符串中含有 i， 否则没有
# *i* 是正则中的通配符。 如果不是交互式shell， 那么直接退出该脚本。 bash 、zsh、fish 都是交互式shell， 
# 所谓交互式，就是你在shell 中输入一个命令，马上就可以得到该命令的结果
[[ $- != *i* ]] && return
#将 ~/.oh-my-zsh 设置为环境变量
export ZSH=$HOME/.oh-my-zsh

# -x:检查后面的文件是否存在并具有可执行权限，也就是检查 /usr/bin/dircolors 文件是否存在且具有可执行权限； 
if [ -x /usr/bin/dircolors ]; then
# -r：检查存在并可读，即检查 .zshrc 同路径下是否存在 .dir_colors 且可读；
# 如果存在、可读，那么执行命令 dircolors -b .dir_colors, eval 作用是将后面的字符串当做命令处理， $()作用是将()内的字符串当做命令处理；
# 如果命令执行错误，那么执行 dircolors -b ，否则不执行；
test -r .dir_colors && eval "$(dircolors -b .dir_colors)" || eval "$(dircolors -b)"
# 执行命令别名
alias ls='ls --color=auto'
alias egrep='egrep --color=auto'
fi

# git theming，关于git目录的提示符号配置
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[yellow]%}%B"

# 设置主题为“ys"，当前使用powerlevel10k
#ZSH_THEME="ys"

# 执行 ~/.oh-my-zsh/oh-my-zsh.sh 脚本
source $ZSH/oh-my-zsh.sh

# 将~/bin 和 /usr/local/bin 通过变量叠加添加到 PATH 变量里，此时的变量 PATH 是本地变量，通过 export 升级为环境变量
# PATH 环境变量的作用，当输入一个命令的时候，会在该变量所包含的路径中查找该命令，所以在安装新的软件的时候，一般会要求
# 用户将该软件所在的二进制可执行程序路径添加到 PATH 中
export PATH=$HOME/bin:/usr/local/bin:$PATH

# -n: 判断变量名时候为空，此处判断变量 SSH_CONNECTION 是否为空；
# 如果是，将 EDITOR 环境变量 设置为 vim，否则是 nvim
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim'
fi

# ! 作用是 非， -d 是判断后面的变量是否存在且是目录文件
# 此处的意思： 判断 ZPLUG_HOME 变量是否不存在且是路径，
# 如果不存在，那么就判断 ~/.zplug 是否不存在，如果不存在，那么就 git clone zplug 到 ~/.zplug 当中
if [[ ! -d "${ZPLUG_HOME}" ]]; then
  if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    # $? 的作用:判断上一个命令是否正确执行，如果上一个命令正确执行，那么上一个命令将会给 $? 赋值为0，否则赋其他值
    # 此处是如果没正确执行，则执行 函数 zplug()
    if [[ $? != 0 ]]; then
      function zplug() {
        return 1
      }
    fi
  fi
  # 如果不存在 ZPLUG_HOME，那么将 ZPLUG_HOME 声明为环境变量
  export ZPLUG_HOME=~/.zplug
fi

# 上面的条件语句的整体的作用是，第一次执行 .zshrc 文件时，是不会存在 ZPLUG_HOME 变量的，
# 也不会存在 ~/.zplug的， 那么就通过 git clone 将 zplug 克隆到 ~/.zplug 文件中，这样，~/.zplug 文件就存在了
# 然后声明 ZPLUG_HOME 为环境变量，此时ZPLUG_HOME 变量也存在了，当以后再运行 .zshrc 的时候，通过第一条判断，
# 就不用运行下面的程序了


#  如果ZPLUG_HOME 存在且是目录文件，那么执行该路径下的 init.zsh 脚本
if [[ -d "${ZPLUG_HOME}" ]]; then
  source "${ZPLUG_HOME}/init.zsh"
fi

# fzf 设置
export FZF_DEFAULT_OPTS='--bind ctrl-k:down,ctrl-i:up --preview "[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500"'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_COMPLETION_TRIGGER='f'    #使用cd f <tab> 就可以使用了， ctrl+i:向上选择，Ctrl+k 向下选择
# 使用 ctrl+f 一样能够打开 fzf, cd ctrl+t 可以实现上面一样的效果
# 在命令行下按下ctrl-f会打开fzf窗口，如果你选中某个条目并按下Enter
# 在命令行下按下ctrl-h, fzf会列出history命令，选中条目并离开fzf的话， 选中条目会被拷到命令行上
export FZF_TMUX_HEIGHT='80%'
export FZF_PREVIEW_COMMAND='[[ $(file --mime {}) =~ binary ]] && echo {} is a binary file || (ccat --color=always {} || highlight -O ansi -l {} || cat {}) 2> /dev/null | head -500'

# -f 作用：判断该文件是否存在，且为普通文件，普通文件包括：txt、脚本、二进制文件、压缩文件，各种程序语言文件
# 此处意思是： 如果~/.fzf.zsh 存在，且是普通文件，那么执行该文件
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 通过 -s 参数设置，以 py 为后缀的文件，直接输入到 terminal 中，自动会用 vi 打开
alias -s py=vi
```

