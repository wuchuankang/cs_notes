### C++编译与链接

1.基本的用法：gcc -o3 fileA.c -o fileB   (编译时用3级优化)
			g++ -o3 fileA.cpp -o fileB    (生成的是可执行文件fileB) 
2.如果是多个文件，那么则可以：

+ g++ testfun.c test.c -o test
+ 有时候为了debug方便，单个文件编译，然后再链接
+ gcc -c testfun.c //将testfun.c编译成testfun.o 
+ gcc -c test.c //将test.c编译成test.o 
+ gcc testfun.o test.o -o test //将testfun.o和test.o链接成test

3.在vim中使用asyncrun.vim插件，可以在不退出编辑页面进行调试运行；

+ 其输出结果是在quickfix窗口，所以先打开窗口：
+ 在normal 模式下，打开：copen 关闭：cclose
+ 要在quickfix窗口下打入命令，只是在1,2所说方法的基础上，加上asyncrun。

4. asyncrun插件的一些快捷键配置参见 ~/.vim/vimrc中的设置
