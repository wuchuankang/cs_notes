## C++ void 类型

void 是无类型，不可以定义无类型变量(否则不知道要分配内存的大小)，但可以定义指向无类型的指针(因为指针所占内存大小是一定的)，无类型指针可以指向任意类型的指针，不需要强制类型转换  
```cpp
int *p1;
float *p2;
p2 = (float *)p1;  //需要强制类型转换，否则编译器会报错
void *p;
p = p2;   // p 可以指向p2 ，但反过来不行
p1 = p;  // 错误，p 不知道内存大小，想要如此赋值，需要强制类型转换
p1 = (int *)p;
```

### 作用
- 做为无返回函数的返回类型
- 不确定类型的函数参数指针(根据实际使用会发生变化)，可以使用 viod *，因为它可以指向任意类型的指针，比如排序函数，需要能够对 int 、float 、char 等多种类型排序，可以使用 void * 作为函数参数；
```cpp
#include <iostream>
#include <cstdlib>
using namespace std;

// 对正整数按照个位数从小到大排列
// 根据问题的要求，定义为 unsigned int ，当然定义为 int 类型也可以，只是那样的话，表示正整数范围变得小了
int MyCompare(const void* elem1, const void* elem2){
    unsigned int * p1, * p2;
    p1 = (unsigned int *)elem1;   // 需要强制类型转换
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
- 对 qsort 函数作解释：  
    qsort 定义在标准库文件(C++ 是cstdlib , c 是stdlib.h)，原函数是：
```cpp
qsort(void *__base, size_t __nmemb, size_t __size, __compar_fn_t __compar)
```
    - void *__base ： 对应的是例子中要排序的数组a，因为数组类型不固定，所以参数定义为 void * 类型指针
    - size_t __nmemb ： 是数组元素个数
    - size_t __size ： 每一元素的大小，所以传参数为：sizeof(unsigned int)
    - __compar_fn_t __compar : 是函数指针，已经用宏定义好了，显式的表示为： int compare(const void *, const void *)  ，该函数具体需要自己定义，例子中根据需求进行了自定义 MyCompare ，__compar 函数对传入的两个参数进行排序,返回值是正数，则elem1排在前面，否则排在后面
结果是对要排序的数组进行原地操作，即经过排序操作后，数组本身顺序已排好，原数组被覆盖掉了
