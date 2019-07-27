### Linux使用教程3

1. 软件安装：

 + 在线安装：sudo apt-get install  filename，该方法可以自动解决包依赖问题

 +  二进制包安装，Ubuntu下是deb包（centos下是prm包）：sudo dpkg -i package.deb

 +  源码包：就是源程序，.tar.gz压缩包，可以网页下载，也可以用wget + url 下载，之后就是在教程2中安装方法实现
   （源码包安装要说明的是，源码包放在：/usr/local/src，软件安装在：/usr/local/软件名，配置文件：/ect/profile）

   /etc/profile：此文件为每个用户设置环境变量的信息。

+ 说明：源码包可以自己指定安装位置，a,b两种方式就不行了，但一般也都是在/usr/local，但是配置问价在哪里呢？

2. /usr 这个文件夹不是user的缩写，而是Unix software resource。 
3. ls 路径 查看该路径下文件，不加，就是查看当前路径下文件,  ls -a 显示当前路径下所有文件，包括隐藏文件
4. 软件源程序安装，有些软件提供了setup.py，那么安装的方式：
   + 先执行 python setup.py build
   + 然后执行 python setup.py install