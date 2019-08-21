# linux 查照命令使用


- find
    - find /yy -name xx :按照名字在路径/yy下查照文件xx，区分大小写
    - find /yy -iname xx : 不区分大小写
    - 可以xx后添加星号作为通配符，表示匹配以xx开头的所有文件
    - 在xx后添加？，表示匹配xx开头，后面只跟一个字符，是非贪婪匹配，上面的通配符是贪婪匹配
    - find 命令耗费资源较多，在系统负载比较高的时候，最好不要用它。

- locate 
    - locate 是在一个文档资料库/locatedb中查照，这个库会为整个文件系统建立索引（除了临时文件路径/tmp）,find查找会耗费系统较多资源CPU，用该命令不会消耗非常少
    - 如果没有locate命令，那么安装：
    ```python
    sudo pacman -S mlocate
    sudo updatedb #更新索引文件库/locatedb，以后系统会定时更新，但查找之前手动更新一下，否则新建立的文件不在其中
    ```
    - locate -i xx :不区分大小写查找xx，没参数则区分大小写 ，-i: ignore的意思

- which 
    - 查找命令或者安装软件所在的路径，which对象是命令，新安装的软件要用which查找，首先软件的能够在shell下用软件名命令打开，比如我想查找chrome安装位置，首先我可以用 goole-chrome-stable 命令俩打开文件的，那么就可以用which来查找：
    ```python
    which google-chrome-stable
    ```
    - 其结果还会返回命令的alias，如果该命令有alias的话；

- whereis 
    - 和which一样，也是查找命令所在的位置，只是它还附带了命令或者软件的manual

- grep : global regular expression print
grep 是文本搜索工具，可以在文本中搜索出指定的字符串，其本质就是用re来的findall用法，只是外加了一个打印到屏幕和一些靠参数带来的功能。
    - grep [option] pattern filename：在文件中查找pattern匹配的东西，比如:
    ```python
    grep -i haha ~/.bashrc  # -i 表示忽略大小写，可以不加，则表示识别大小写。在文件 ~/.bashrc 中找 'haha'
    ```
    - grep 的对象是文件，但是在管道中的用法时候，可以在标准输出中查找，这也是管道的作用，使得上一个命令的输出作为下一个命令的输入：
    ```python
    lspci | grep "Ethernet"
    ```
NOTE:  
通配符* 和 正则中的作用是不一样的。通配符匹配任意多个字符，在一些cp、mv、rm中使用。这些命令也不支持正则，支持正则的是grep，它就是使用正在在文件中查找指定内容.
