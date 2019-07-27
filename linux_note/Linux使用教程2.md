### Linux使用教程2

1. 打开pdf 命令：evince file.pdf ；  evince是一种轻量级的PDF文本阅读器

2. 查看文件内容： cat  filename
    还有：more filename 
    	   less filename 

3. cd 回到用户目录（家目录），即～下，并且家目录也是个跳转的窗口，比如现在在/etc下，我想到～/Downloads，可以直接cd ～/Downloads

4. cd 到当前文件下的某一个文件夹里，可以直接 ：cd  filename，而不需要 cd ./filename

5. 编译安装二进制文件，以安装curl为例：

    + 先从网上下载，可以用网页下载，也可以用命令：wget url地址

    + 解压 : tar -zxf curl***.tar.gz  -C /usr/local/scr (这个是专门存放第三方源程序的地方)***

    + 进入解压目录： cd curl***

    +  运行配置文件，并指定安装目录：sudo ./configure --prefix=/usr/local/curl   (--prefix是指定安装目录，很重要)

    + 进行编译：sudo make

    + 安装： sudo make install

    + 加入环境变量：sudo export PATH= \$PATH:/usr/local/curl/bin

      上面的一步只对当前有用，关机重启后失效了，所以需要用文本保存设置：sudo vim /etc/profile 在里面添加：export PATH=$PATH:/usr/local/curl/bin

        	(这里的bin文件就是d步中设置的目录下经过安装后的二进制可执行文件，这样curl命令就可以找到位置，可以直接使用了)  
    + 说明：对于安装的程序，不一定都是可执行文件，也有的是函数库，比如zlib，如果在shell中直接输入zlib，会显示找不到这个命令，因为本身就不是
      	函数，那么怎么知道自己安装成功了呢？用whereis zlib来查询，如果给出安装路径，那么就表示安装成功。

6. 终端中删除当前命令：如果一键键的backspace很麻烦，可以使用：ctrl+u  或者 ctrl+c(这是取消当前命令)

7. linux 中的命令，一杠表示参数：是缩写的字符，比如 -r -rf ； 二杠是单词，一般表示说明性的帮助性质的，比如：--help,--version

8. 查询命令：find path -name 要找的东西 ； 例如：find  /  -name "*.c" 查找在根目录下（全盘查找）后缀是.c的文件，，find  .  -name so  在当前目录下查找so文件

9. 查看是否安装了某个程序： whereis 程序名 ，比如whereis typora，如果安装就会给出安装的路径

10. 系统中可能安装了多个版本的程序，要想知道当前的的程序是哪一个，可以用which，比如 which curl，有时候，另外一个软件是需要特定版本的curl，那么就要
    看看当前在系统中运行的是哪一个版本，如果不是，删除后，将需要版本的curl加入到环境变量中。