## C++ 关键概念辨析

### 指针数组 / 数组指针

- 对于指针，可以将其像int、float 等类型同等看待，有整型数组，对应于有指针数组，整形数组，每一个元素是一个整型变量，指针数组每一个元素是指针，最常见的例子是 main 函数：

```cpp
int main(int argc, char * argv[])
```
其中第二个元素就是指针数组，每一个元素的类型就是(char *)，那么 argv[0] 就是指向第一个字符串，在这里就指向可执行文件名，arg[1] 指向第一个参数名  
一个完整的例子：将命令和参数都打印出来：
```cpp
#include <iostream>
using namespace std;

int main(int argc, char * argv[]){
    for(int i=0; i<argc; i++){
        cout<<argv[i]<<"  ";
    }
    return 0;
}
```
- 数组指针： 也叫行指针
```cpp
int (*P)[n]   // ()优先级高，p 是个指针，指向的是一个一维数组，这个一维数组的长度是n，也可以说 p 的步长是n
```
```cpp
int (*p)[5];   // 定义了一个指针，该指针指向包含5个元素的一维整型数组，一般作为指向二维数组的函数参数使用
int a[3][5];    // 
p = a;  // 将二维数组的首地址赋给p，也就是a[0]或&a[0][0]
p++; //将指向a[1][]，这就是也叫行指针的原因
```
```cpp
#include <iostream>

using namespace std;

//void fun(int (*p)[3]){
//  cout<<p[0][0]<<endl;
//}

// 形参中定义的二维数组 a[][3]，其名a 在函数中就是指向第一个一维数组的指针，而不是相当于
void fun(int a[][3]){   // 上面注释掉的代码和该函数完全等同
    cout<<a[0][0]<<endl;
}

//void foo(int *p){
//    cout<<p[0]<<endl;
//}

void foo(int a[]){      // 上面代码等同
    cout<<a[0]<<endl;
}

int main(int argc, char * argv[]){

    int a[][3] = {{1, 2, 3}, {4, 5, 6}};
    int b[2] = {2, 4};
    fun(a);
    foo(b);
    return 0;
```

###  指针常量 / 常量指针
- 指针常量不能更改所指向地址中的内容，但可以更改所指向的地址，目的是前者：
```cpp
const int *p;   // const 修饰的是int，也就是指针所指向地址中的内容; 当不想在函数中改变函数参数的实参值，可以将该参数写成指针常量
// 等同的写法
int const *p;
```

- 常量指针：不能更改指针所指向的地址，可以更改所指向地址中的内容，目的是前者：
```cpp
int * const p;  // const 修饰的是指针，也就是指针指向的地址，因为指针就是存放地址类型变量
```


### 常引用



### 函数返回值：引用 / 指针


