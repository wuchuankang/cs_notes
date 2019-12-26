## 函数指针

- 指向函数的指针，函数名是函数入口的地址，因此可以将函数名赋值给函数指针，但是指针是有类型的，比如 int *p 就是指向整形的指针，所以函数指针也要符合对应参数和返回值类型一致。  
- 写法: 类型 (*pf) (参数) ，例如： int (*pf)(int , char)
- 用法： 以上面的例子接着为例：pf 要指向一个参数是 int 和 char 类型(顺序也要一致)返回值是 int 的函数，用的时候和原函数一样使用
```cpp
#include <iostream>

using namespace std;

void PrintMin(int a, int b){
    if(a < b)
        cout<<a<<endl;
    else
        cout<<b<<endl;
}

int main(){
    void (*pf)(int , int);
    int x=4, y=5;
    pf = PrintMin;
    pf(x, y);
    return 0;
}
```
- 函数指针用于排序的例子，使用标准库文件<stdlib>中的qsort 函数，其中qsort 函数最后一项函数指针所指向的函数需要自己定义，具体可参见 ./void_note.md ;
```cpp
#include <iostream>
#include <cstdlib>
using namespace std;

// 对正整数按照个位数从小到大排列

int MyCompare(const void* elem1, const void* elem2){
    unsigned int * p1, * p2;
    p1 = (unsigned int *)elem1;
    p2 = (unsigned int *)elem2;
    return (*p1 % 10) - (*p2 % 10);
}

#define NUM 5

int main(){
    unsigned int a[NUM] = {8, 123, 11, 10, 4};
    qsort(a, NUM, sizeof(unsigned int), MyCompare);
    for(int i=0; i<NUM; i++){
        cout<<a[i]<<"  ";
    }
    return 0;
}
```


