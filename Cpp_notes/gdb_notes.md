## gdb 调试
gdb 安装可以参照 ~/repos/dotfiles/README.md，也可以使用 vim8/neovim 自带的 termdebug 调试插件，该插件是默认安装的

### 启动

- 在terminal 中: gdb + 带调试信息的文件 / gdb => file 带调试信息的文件
- 在vim中：packadd termdebug , termdebug 
- run/r ：直接运行到断点
- start ：运行到main函数入口

### 运行

- n(next) : 下一步
- s(step) : 下一步，如果遇到函数可以进入函数内部，但是如果C++默认定义的，因为使用的是静态库或者是动态库，所以进不去，从而会报错，这个时候需要重新运行；只有自己定义的函数能够进去
- finish : 调试函数，如果不想再进行跟踪，可以使用 `finish` 来退出函数。
- c(continue) :调到下一个断点，
- 如果可执行程序需要参数，在 termdebug 中，假设可以执行文件是 main , 那么在 gdb 窗口，file main , 然后进行如下的参数设置：
```cpp
set args xxx xxx  //xxx是参数
```
- set 不仅可以设置程序可执行参数，还可以设置程序运行过程中变量的值，方法就是
 ```cpp
set a=23  //其中a 是程序运行过程中的变量，23是自己设置的值，如果a是某个函数中的局部变量，还要加上限定域，
// 比如，如果a是函数fun.c 中的，要写为:
set fun.c:a=23
 ```

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

- display variable : 一直显示某个变量、函数



