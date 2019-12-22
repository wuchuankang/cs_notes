## Makefile 编写

makefile 运行规则：  
1. 通过：make 执行，执行的时候运行第一个目标，然后递归的运行第一个目标中的依赖  
2. 当依赖(以及递归依赖)文件没有发生改变的时候，则不会执行

### Makefile 命名规则

- makefile
- Makefie

### makefile 三要素

- 目标
- 依赖
- 规则  
**NOTE:** 
    1. 写法：
        - 目标：依赖  
        **tab键** 规则
    2. 依赖、规则不是必须的，只有依赖的是可以放在第一个目标当做总的目标，比如有的makefile 用 all: xxx xxx ，只有目标的是伪目标，比如clean

### 例子  

在 ./makefile_example 中 include 和 scr 文件夹， scr 中有 add.cpp、sub.cpp、mul.cpp、main.cpp，那么依据 makefile 的基本规则，可以写成下面简单的方式：  

```makefile
main: add.cpp sub.cpp mul.cpp main.cpp
	@g++ -o main main.cpp add.cpp sub.cpp mul.cpp

.PHONY:clean

clean:
	-@rm main
```
上面的几点说明:  
- @ 作用是将命令实施时候，不显示命令行，  
- - 作用是当命令实现有错误的时候，继续执行。这里的rm，如果没有main，那么实施rm main 就会出现错误(当然也可以使用 rm -f main 进行强制删除，也就是说如果删除了不存在的东西，不会报错)，如果该命令下还有其他命令就不会执行。
- .PHONY 作用是将 clean 当做是命令，如果同文件夹下有 clean 文件，那么该文件不会当做是 makefile 中的伪目标。

### 改进
上面的 makefile 写法是不可取的，因为如果cpp很多，g++ 命令需要写的很长，另外，根据 makefile规则，如果我们更改了某一个文件，比如 add.cpp ，其他文件没有改动，实际上是无需编译其他文件的，但是上面写的makefile，将所有的文件都重新编译了一遍，要避免如此，需要将其分开来写。可以改成下面：
```makefile
main: add.o sub.o mul.o main.o
	@g++ -o main main.o add.o sub.o mul.o

main.o: main.cpp
	@g++ -c main.cpp
sub.o: sub.cpp
	@g++ -c sub.cpp
mul.o: mul.cpp
	@g++ -c mul.cpp
add.o: add.cpp
	@g++ -c add.cpp

.PHONY:clean

clean:
	-@rm *.o
	-@rm main
```
**NOTE :**
    - g++ -c main.cpp 生成的结果默认就是 main.o
    - main.cpp 中调用了 add.cpp 中的 add 函数，但是编译(其实包括预处理、编译、汇编得到了mian.o) main.cpp 的时候，依赖并不需要 add.cpp，为什么呢？这是因为将cpp汇编成为二进制文件(不是可执行文件)，只需要依赖该源文件，并指定头文件路径即可，这里不需要另外指定头文件的原因，是因为在源文件中添加所需的头文件(该头文件中声明了自定义的函数、类、变量等)的时候，已经用相对路径标明了头文件位置。  
    - 另外还可以如此理解：如果不添加自己定义的头文件，只添加标准头文件，汇编该源文件时，依赖中也没有给出标准头文件对应的源文件，可见是不需要的，  但是想要链接成为可执行程序的时候，main.cpp 调用了什么函数，则需要对应的源程序或该源文件汇编而来的二进制文件。


### 再改进
上面避免了第二个问题，但是当文件过多的时候，依然要写很多很长，可以使用 makefile 提供的变量与函数来简化写法，并将写法通用化。

#### makefile 语法规则
1. 变量
    - 变量： ObjectFiles = add.o mul.o main.o
    - 变量的使用符合shell 编程语法规则，要想提取变量中的值，要在变量前面加 $ObjectFiles
    - 内置变量：
        - $@    ：代表目标
        - $^    ：所有依赖
        - $<    ：第一个依赖
        - $?    ：第一个变化的依赖

2. 函数
    - wildcard ：(通配符)可以进行文件的匹配
    - patsubst ：内容的替换  

通过上面的变量和函数，可以改写：   

```makefile
# 得到所有的 .c 文件
ScrFiles = $(wildcard *.cpp)

# 其中 % 通配符，用于模式匹配，就是对应格式，一一匹配所有符合项，
# 下面语句的作用是 ScrFiles 中每一带有 .cpp (%.cpp) 的都通过替换函数一一替换为 .o (%.o)文件
ObjFiles = $(patsubst %.cpp, %.o, $(ScrFiles))


main:$(ObjFiles)
	@g++ -o $@ $(ObjFiles)

# 模式匹配，具体就是：上面依赖 $(ObjFiles) 中第一项是
# 某一个 .o，因为找不到，根据递归推导，会向下查找， %.o 就对应了依赖中要找的那一项，
# %.cpp 就对应了当前路径下与前面 % 符所对应的源文件
# $@ 代指目标文件，也就是 %.o ， $< 代指第一个依赖文件，这里依赖文件也就一个 %.cpp，所以也就是 %.cpp
%.o:%.cpp
	@g++ -o $@ -c $<

.PHONY:clean

clean:
	-@rm -f *.o
	-@rm -f main

test:
	@echo $(ScrFiles)
	@echo $(ObjFiles)
```

### 再再改进

这里仍需要改进的有两点：  
1. 这里的 makefile 文件是和源码放在一起的，当源码文件过多的时候，将 makefile 文件放在其中，比较混乱，应该放在 ./scr 和 ./include 同级较好，而不是放到 ./scr 内部。
2. 不同平台(也就是不同的操作系统)下编译工具不同，在 linux 下对于 c 是 gcc， 对于cpp 是g++，但是在windows 下另有不同，所以想要跨平台编译，需要不同的编译器，如果将编译器设置为一个变量，那么 makefile 在其他平台编译修改的就少很多  

```makefile
# 得到所有的 .c 文件， 补充匹配的文件路径，
# 现在 ScrFiles 值在每一个 cpp 前面加上了 scr/
# 相应的， ObjFiles 在每一个 .o 前加上了 scr/
ScrFiles = $(wildcard scr/*.cpp)

# 其中 % 通配符，用于模式匹配，就是对应格式，一一匹配所有符合项，
# 下面语句的作用是 ScrFiles 中每一带有 .cpp (%.cpp) 的都通过替换函数一一替换为 .o (%.o)文件
ObjFiles = $(patsubst %.cpp, %.o, $(ScrFiles))

# 编译器有默认的变量是 CC ，自己定义的变量 Comp 不可用
#Copm = g++
CC = g++

main:$(ObjFiles)
	@$(CC) -o $@ $(ObjFiles)

# 模式匹配，具体就是：上面依赖 $(ObjFiles) 中第一项是
# 某一个 .o，因为找不到，根据递归推导，会向下查找， %.o 就对应了依赖中要找的那一项，
# %.cpp 就对应了当前路径下与前面 % 符所对应的源文件
# $@ 代指目标文件，也就是 %.o ， $< 代指第一个依赖文件，这里依赖文件也就一个 %.cpp，所以也就是 %.cpp
%.o:%.cpp
	@$(CC) -o $@ -c $<

.PHONY:clean

# 补充删除的文件路径
clean:
	@rm -f scr/*.o
	@rm -f main

test:
	@echo $(ScrFiles)
	@echo $(ObjFiles)
	#@echo $(Copm)
```
 **Note**:
 1. 现在可以将 makefile 放在 ./scr 同级，生成的 .o 文件在 ./scr 内部。
