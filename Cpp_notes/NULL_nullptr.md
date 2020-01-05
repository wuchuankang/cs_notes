## 空指针 NULL nullptr
- 指向0地址空间的指针是空指针，空指针也就是赋值为0地址的指针，0地址更具体的说，就是内存空间中标记为0 的那个地址。
- NULL 是C++ 中的宏，NULL 的值是0。
    ```cpp
    int *p = NULL；  // 等价于 int *p = 0;
    ```
    1. 意思是将地址0 分配给p，为什么初始化的时候，一般要将指针初始化指向地址0的空间呢？我们知道指针初始化，就是避免指针乱指向，避免是野指针，但是为什么是指向为0的地址呢？这是因为在大多数计算机中，用户程序不能访问地址为 0 的内存，因为它被操作系统数据占用。这使得 0 成为指示无效内存位置值的安全选择。  
    2. 许多头文件（包括 iostream、fstream 和 cstdlib）定义了一个名为 NULL 的常量，代表指针值 0。因此，要想使用 NULL ，需要先包含这些头文件中的一个； 

- 那么为什么又需要 nullptr 呢？因为 NULL 是0，有时候当NULL作为指针参数实参的时候，如果存在重载，不知道 NULL 所代表0 是int，还是0地址； 而 nullptr 也是指的是0地址，只是它能够明确的传递是地址，而非int 类型；
    ```cpp
    #include <iostream>
    using namespace std;
    
    void foo(int a){
        cout<< a <<endl;
    }
    
    void foo(int *p){
        cout<< "joke" <<endl;
    }
    
    int main(int argc, char *argv[]){
        //foo(NULL); // 这个编译器会报错，出现二义性
        foo(nullptr);   //joke ，能够正确的传递地址
        
        return 0;
    }
    ```
- 到这里，就自然明白非空指针的判断为什么是：
    ```cpp
    if(!p); //最常使用
    //等价于下面3种
    //if(p != NULL);
    //if(p != nullptr);
    //if(p != 0);
    ```
    这是因为p如果是空指针，那么p = 0; 地址一般使用16进制表示，其实不论多少进制，0地址的地址表示就是0.
