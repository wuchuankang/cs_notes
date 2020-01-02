## extern 修饰符

- extern 修饰符可以用来定义全局变量，当对个源文件都要使用某一个变量的时候，可以将该变量在头文件中声明为 extern (外部) 变量，用extern声明的时候，仅仅是声明，编译器在预处理阶段(处理头文件)并没有分配内存，要在某个源文件中定义该变量，其他文件使用该变量，要包含相应的头文件，比如：  
- extern 一般用来定义 const 形全局变量，若果是非 const 形常量，在不同的源文件中使用该变量，都可能使得该变量发生变化；
- exam.h 文件
```cpp
#ifndef EXAM_H
#define EXAM_H

#define PI 3.1415926   // 定义宏
extern int test;
const int M = 5; // 在声明的同时对M 进行了定义
extern const int MAX;  // 声明和定义分开

void foo();

#endif
```
- foo.cpp 
```cpp
#include "exam.h"

const int MAX = 1000; // 也可在其他源文件中定义；
void foo(){
    test += 1;
}
```

- main.cpp
```cpp
#include <iostream>
#include "exam.h"

using namespace std;


int test = 4;
int main()
{
    foo();
    cout<<test<<endl; // 5
    cout<<PI<<endl;     // 并不存在 PI 变量，只是个宏，在预处理阶段，会将 PI 替换为 3.1415926 , 用于后面的编译 、 汇编 、链接
    cout<<M<<endl;  //5
    return 0;
}
```

## 关键：在头文件声明并定义 VS 声明和定义分开
前者： 编译该头文件的源文件在进行编译的时候，都会独立的生成一份该常量的copy，会浪费空间；  
后者： 就只有实现定义的源文件中这些变量的一份，就是所有其他 include 该头文件的函数，当使用该变量时候，变量都是定义中的那一个，而不是copy，节省空间。  
例子：  
```cpp
const char * const ERR_DESP_NO_MEMORY = "There is no enough memory!"
```
上面是《高程程编程指南 C++/C 语言》中的例子。该头文件中实现了字符串常量声明和定义，那么包含了该头文件的每一个编译单元(就是每一个包含了该头文件的源文件) 不仅会为每一个常量指针常量(const char *const) 创建一个独立的copy ，还会为长长的字符串字面常量创建一个独立的拷贝项，就相当与每一个编译单元内分别定义和初始化了每一个常量一次，如果是 int 或者 float 还好(浪费不大)，但是字符串就多了，尤其对嵌入式开发来说就是大事了。

## 宏(macro)
- C++ 中定义宏，也是全局变量，只是宏并不分配内存，只是进行代码的替换，在其他源文件中 #include 包含宏的的头文件，就可使用，在预处理阶段，会将宏所代表的东西进行替换。如上面的例子。  
- 那么使用 宏来定义全局变量，还是使用 extern const 呢？ 宏没有类型，编译器可以对 const 常量数据进行静态类型安全检查(比如：cppcheck静态类型检查工具)，其次，debug 的时候，可以对const 变量进行调试。

## 对于全局变量，在哪里定义？  
使用某一个公共的头文件，将所有的全局 变量或者宏都声明其中，也可以直接定义；  
例如 ： 公共头文件名： CommonDef.h
```cpp
extern const int MAX_LENGTH;  // 在其他源文件中定义一次并初始化
//const int MAX_LENGTH = 1024;   // 或者像这样，直接声明并定义，则 包含该头文件，就直接可以使用该变量了
#define PI 3.14
```

