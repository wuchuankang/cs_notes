## gdb 调试
    gdb 安装可以参照 ~/repos/dotfiles/README.md，也可以使用 vim8/neovim 自带的 termdebug 调试插件，该插件是默认安装的

### 启动

- 在terminal 中: gdb + 带调试信息的文件 / gdb => file 带调试信息的文件
- 在vim中：packadd termdebug , termdebug 
- run/r ：直接运行到断点
- start ：运行到main函数入口

### 断点

- break/b n : 在函数入后的文件中第 n 行设置断点
- b foo.cpp:foo ：在源文件 foo.cpp 中的 foo 设置断点
- info/i b/break ：显示已经设置的断点
- disable n ：将第n个断点（不是第n行的断点，断点有自己的标号）失效
- enable n ：作用相反
- delete breakpoints ：删除所有的断点
- delete n ：删除第n个断点
- clear n ：删除设置在第n行的断点

### 查看变量/函数
查看变量，需要在程序运行的时候，才可以进行下面的命令，因为只有在运行的时候，才能发现变量的名字。

- watch variable ：查看



