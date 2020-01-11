# shell 中的变量和关键的环境变量

## 变量的分类
 - 用户自定义的变量
 ```sh
 name=cc
 echo $name   # $是提取变量的值，在比如经常要查看的是 echo $PATH 环境变量
 ```
 - **变量的命令=两端不能有空格！这个经常会出错！**
 - set：可以查看所有定义的变量，不只是自定义的变量
 - unset name : 取消所定义的变量为name的变量,比如经常要取消全局代理变量：
 ```sh
 unset all_proxy && unset ALL_PROXY # 注意使用了&& 多命令执行符，表示逻辑与，前一个命令执行，后一个命令才执行
 ```

 - 环境变量
环境变量 相当与c 语言中的外部变量，意思外部的文件也可以用此变量，这也从两者都用export 来定义变量，可见意义上的一致性。环境变量的存在使得shell编程得到简化和通用，和c 语言中外部变量的好处是一样的，那么它和alias的区别是什么呢？alias是对命令取别名，然后在shell终端使用，不能用于shell的编程使用。  
我们经常听说安装某个软件后，要添加环境变量，否则软件不能使用，有些时候没添加环境变量，程序也能使用，再说，添加环境变量，环境变量是什么呢？  
其实意思是，安装某个软件，运行某个软件，那么该软件运行指令要能找到，而查找指令是通过PATH 这个变量中路径中一次查找，找到第一个该命令就执行，找不到就报错： command not known! ,所以要将该命令所在路径添加到PATH变量中。为什么一些软件不用添加就直接可以执行？那是因为一般用户安装的软件，系统会默认安装在/usr/bin或者/usr/local/bin中，而这些路径已经包含在PATH 变量中了。可以通过 echo $PATH 来查看其包含的路径，如果安装程序的路径不在当中，那么就要在 PATH 中添加。  
在哪一个文件中添加呢?  
linux 原来默认的是bash shell，我已经更该为 fish shell，那么在 ~/.bashrc 和 ~/.bash_profile 中添加的环境变量只能在当前用户的bash中有效，当然可以在 /etc/profile 中添加，那么对所有用户有效，也对fish有效。但为了每个用户的可定义性，一般子用户目录下的配置文件中更改，要是每个人都在 /etc/profile 中更改，那么就会给每个用户使用造成混乱。所以fish在其 ~/.config/fish/config.fish 中添加即可。

    - env : 查看系统中所有的环境变量，不包括自定义变量，set是所有变量；
    - 环境变量是系统变量，添加到环境变量后，就可以在任意一个shell中使用该变量，环境变量是一个全局的变量。最常见的就是路径变量 PATH
    - unset 取消变量设置，通过env可以知道all_proxy 和 ALL_PROXY都是环境变量。可以通过上面的语句取消

    - PATH : 系统查找命令的路径，相当重要！

## 变量的叠加
变量可以用叠加的方式更改，其格式：  

```sh
aa = '123'
aa = '$aa'456
PATH = '$PATH$':xx #将xx目录添加到系统PATH 环境变量中，添加：的原因是path值是各个路径用：分开的。
```

## NOTE
- 上面所讲的，是在bash中执行的，只对当前有用，一旦系统重启，其定义的普通变量还是系统变量都会无效，也就是被删除掉，要想永久有效，得放到相应的配置文件中。
- 如果环境变量的值是某个命令或者软件启动的命令路径，那么 $变量 就可以使用该命令，例如：  
    ```sh
    export EDITOR=/usr/bin/nano
    export chrome = /usr/bin/google-chrome-stable
    $EDITOR #启动 nano
    $chrome #启动chrome
    ```
- 系统的配置文件
    - /etc/profile
    - ~/.bash_profile
    - ~/.profile  
    - ~/.bashrc   对于login 模式，会读取 /etc/profile ，另外 ~/.bash_profile 和 ~/.profile ，如果存在前者，则后一个不读取，这是在Ubuntu，centos，在manjaro中则反过来，会读取后者，而不读前者。会存在这两个的原因是shell发展历史中不同的命名习惯造成的，用户可以二选其一。重要的是这两个只是对bash shell 有用
    - ~/.config/fish/config.fish  : fish的配置文件
