## c/c++ 头文件和库文件
c/c++ 中已经有好多自定义好的库文件，这些库文件一般是已编译成为动态库文件，通过给出头文件接口，我们通过 #include <头文件名> 来进行调用其中的函数。  
c++ 是向下兼容c 的，所以c 中的头文件，c++ 也可以使用，c中的头文件去掉".h"并在前面加上"c" 就变成了 c++ 头文件，比如：
```cpp
#include <stdlib.h>  // c
#include <cstdlib>  // c++
#include <math.h>  //c
#include <cmath>  //c++
```
这两者没有什么功能上的区别，函数接口也是相同的，只是 c++ 库中的文件使用c++ 语法实现，更贴合c++ ，所以一般使用c++ 对应的头文件，要使用c 的也没啥问题。

### 头文件汇总

#### stdlib.h / cstdlib
这个是标准库头文件，包括：
1. 字符串转换为数字的函数，包括atoi, atof, strtol等。
2. 随机数函数，包括srand, rand等。
3. 内存分配释放函数，如malloc,calloc,realloc,free等。
4. 程序运行控制函数，如exit, abort等。
5. 系统访问相关函数，如printenv, setenv，system等。
6. 常用算法函数，如qsort, bsearch, abs,div等。

#### 其他的参见

其他头文件[点击链接](https://blog.csdn.net/u012707739/article/details/76359238)
[点击之](https://blog.csdn.net/linhaiyun_ytdx/article/details/48065259)
