## 面向对象

### 访问范围

1. private : 
    - 私有成员变量：    私有或者公有成员函数可以访问， 外部不可以
    - 私有成员函数：    公有成员函数可以访问，外部不可以

2. public ：
    - 公有成员变量、函数：  公有成员函数、外部可以访问

3. protect ：


### 成员函数的重载和缺省参数

### 构造函数

- 用于初始化成员变量的，当没有自定义的构造函数，则**编译器** 会自动生成一个构造函数，但这个构造函数什么也不做；  
- 成员变量在构造函数中初始化顺序，**当使用初始化列表，只与在类中声明的顺序有关，先声明的先定义，和在初始化列表中出现的顺序无关，这个尤其重要**；但如果在构造函数体内赋值，那么定义的顺序就是函数体内的顺序
    ```cpp
    class Dg{
    public:
        int a;
        int b;
        Dg(int b_);
    };
    // 写法错误，当使用初始化列表的时候，先初始化的是a，但是a 用了未初始化的b，所以后面会为错误
    Dg::Dg(int b_):b(b_), a(b+1){  
    }
    
    int main(int argc, char *argv[]){
        Dg dog(3);
        cout<<dog.a<<endl;  //非常大的一个值，每次运行都有不同
        return 0;
    }
    ```
- 可以有多个构造函数，也就是说构造函数可以重载；
- 没有返回值;  
- **构造函数是用来初始化的，就是对成语变量分配内存空间和赋值这两个动作的，所以类中成员变量的写法只是个声明**
    ```cpp
    struct Test
    {
        Test(int a):i(a){}
        int i ;
    };
    
    struct Te
    {
        Test test;   // 其他类的成员变量，这里只是声明，不是定义，所以无需调用构造函数(Test 构造函数带有参数)，所以也就不需要给test填写参数，它的定义在Te的构造函数
        Te(Test &t)  // 构造函数，
        {
            test = t;  //这里进行赋值操作，test对象先用调用 Test构造函数进行定义，再赋值，但是这里构造函数是有参的，所以编译器会报错 
        }
    };
    ```
补充：  
- **Te 结构体中的 Test test， 之所以不能写成 Test test(2)，这是因为如果这样写，就是在声明的同时进行了定义和初始化，而创建 Te 的对象时，又调用了构造函数进行初始化，造成混乱；**
- 声明只要给出变量的类型和变量名就行了
    ```cpp
    #include <iostream>
    
    using namespace std;
    
    class Complex{
    private:
        double real, imag;
    
    public:
        Complex();
        Complex (double r);
        Complex (double r, double i);
    
        void getValue();
        Complex (Complex c1, Complex c2);
        ~Complex (){};
    };
    
    Complex::Complex(){
        real = 0;
        imag = 0;
    }
    
    Complex::Complex(double r, double i){
        real = r;
        imag = i;
    }
    
    Complex::Complex(double r){
        real = r;
    }
    
    Complex::Complex(Complex c1, Complex c2){
        real = c1.real + c2.real;
        imag = c1.imag + c2.imag;
    }
    
    void Complex::getValue(){
        cout<<real<<endl;
    }
    
    int main(int argc, char *argv[]){
        Complex c0;     // 用到的是第一个构造函数，因为没有参数，使用下面的定义对象也一样，但是无参数的时候，一般使用这样定义的对象
        //Complex c0();
        Complex c1(2, 3);
        Complex c2(4);
        Complex c3(c1, c2);     // 这个要注意
        Complex *pc = new Complex(4, 5);    // 这个重要，要将参数加上
        pc->getValue();     // 指向类的指针，使用的是 "->" 符号访问成员
        c3.getValue();      // 对象使用的 "." 访问成员
        
        return 0;
    }
    ```
Note:  
- 上面构造函数最好使用初始化列表，上面的构造函数是虽然名义上是用来初始化类的成员变量，但是不一定是对变量进行初始化操作，比如上面的构造函数，都是在函数体内部对成员变量进行赋值操作的，注意是赋值！**初始化与赋值的在操作任务量的区别，前者是在分配内存的时候，直接给定一个值，后者是先分配内存，然后再赋值，多了一次赋值操作**;  
- 通过上面的分析，可以知道，通过初始化列表的好处；另外如果类中存在 const 成员变量，因为 const 变量必须初始化，如果使用在函数体内部进行赋值，那么编译器就会报错，则必须使用初始化列表；  
- 另外一个关键的地方就是在继承的时候，因为子类不能够访问父类的私有成员，但子类的构造函数要给出父类对象的构造过程，如果在构造函数体内进行赋值操作，但又无法给父类的私有成员变量初始化，用初始化列表能很好的解决这个问题！
    
    ```cpp
    #include <iostream>
    using namespace std;
    
    class Bug{
    private:
       int nLegs;
       int nColors;
    
    public:
       int type;
        Bug(int legs, int colors);
    };
    
    Bug::Bug(int legs, int colors):nLegs(legs), nColors(colors){
    }
    
    // 公有继承
    class FlyBug:public Bug{
    private:
        int nWings;
    public:
        FlyBug(int legs, int colors, int wings);
    };
    
    FlyBug::FlyBug(int legs, int colors, int wings):Bug(legs, colors), nWings(wings){
    }
    
    // 错误的构造函数
    /*FlyBug::FlyBug(int legs, int colors, int wings):{*/
        //nLegs = legs;  // 因为不能访问到 基类的私有成员
        //nColors = colors;
        //nWings = wings;
    /*}*/
    
    int main(int argc, char *argv[]){
        FlyBug fb(2, 3, 4);
        
        return 0;
    }
    
    ```

    ```cpp
    class Complex{
    private:
        double real, imag;
        const int m_data;
    
    public:
        Complex (double r, double i);
    
        void getValue();
        Complex (Complex c1, Complex c2);
        ~Complex (){};
    };
    
    Complex::Complex(double r, double i, int n):real(r), imag(i), m_data(n){ 
    
    }
    ```

### 复制构造函数
同样，如果没有自己定义，则**编译器** 会自动生成一个复制构造函数；  
复制构造函数不允许多个，因为复制构造函数是做复制操作，没法用参数个数和类型来区分用了哪一个复制构造函数，所以只有一个；  
没有返回值，参数是类的引用或者常引用。  
    ```cpp
    X(X&);  //X是类名
    X(const X&);    // 常引用，说明复制构造函数不允许改变被复制对象，这是合理的，因为复制操作，不需要改变被复制对象
    ```
参数是引用的原因：**如果不是引用，在传递参数的时候就会被调用复制构造函数，而这个函数本身就是复制构造函数，会造成无穷的递归调用**  
	
1. 使用方式
    - 当不自定义复制构造函数，那么编译器会自动生成一个复制构造函数，该函数将实现**浅拷贝**，也就是只是实现了赋值操作；  
    - 浅拷贝和深拷贝的区别，前者只是实现简单的赋值操作，当类中存在指针成员变量，因为只是赋值，那么两个指针将指向同一块地址，每一个对象在结束后都会调用西沟函数，那么使用浅拷贝的两个对象的析构，将对指针指向的同一块内存析构两次。深拷贝就是对于指针成员变量，另开辟内存空间，其他的成员变量进行赋值就够了。要想实现深拷贝，只能自己实现。具体可参见[浅拷贝和深拷贝的区别](https://blog.csdn.net/u010700335/article/details/39830425)。

2. 复制构造函数起作用的2种情况
    - 用对象去初始化另一个对象(赋值不是，赋值调用的默认的赋值运算符"="，或者是该运算符的重载)
    - 对象作为函数的参数，(由于会调用赋值构造函数造成消耗，所以一般使用对象的引用作为参数)
    - 补充：返回值是对象(不是对象的引用), 以前是要调用复制构造函数，现在编译器对函数进行了优化，不需要再调用复制构造函数，直接返回值了。(**如何直接返回？是调用了赋值运算符么？尚不清楚**)
    - **补充：函数调用中参数传递的本质是：是用实参来初始化形参，而不是替换，注意是初始化！！！所以可以说，复制构造函数调用就只有一种情况，那就是只有初始化另一个对象的时候被调用**

### 函数返回值： 引用 和 指针
对于在函数内部定义的临时变量和指针，是不能作为函数返回值的，这是因为在return该量的时候，发生了复制工作(不一定是赋值，赋值运算符=在C++会被重载,这个时候，赋值就不一定是复制了)。  
当是指针的时候，接收的指针=return的指针，但是当return结束后，临时变量都会被销毁，那么接收的指针指向的地址也被消亡了，变成了野指针；  
当返回值类型是引用的时候，返回的就是return 变量的引用，其实返回值直接就是该变量本身，因为引用只是变量的别名。当return 的是临时变量的时候，因为会被销毁，所以编译会出错；  
返回值是引用，也就是被引用变量本身，所以该函数就是左值，可以放在等号的左边，进行其他操作；  
要注意的是，当参数是是引用的时候，直接return 引用就可以了。
    ```cpp
    #include <iostream>
    using namespace std;
    
    int gl = 2;
    int & foo(){
        gl = 1;
        return gl; // 返回的是gl 的引用
    }
    
    int & fun(int &a){
        a += 1;
        return a; //返回的是a的引用
    }
    
    int main(int argc, char*argv[]){
        foo() = 4;
        cout<<gl<<endl; // 4
        int a = 2;
        fun(a);
        cout<<a<<endl;  //3
        int b = foo();
        cout<<b<<endl;  //1
        cout<<gl<<endl; //1
    
        return 0;
    }
    ```

### 左值和右值
左值是能够用取地址取得地址的变量，不是左值的就是右值；  
具体可参见[C++11 左值、右值详解](https://blog.csdn.net/hyman_yx/article/details/52044632)


### const 关键字
要讲const作用，要先从需求说起，就是希望在使用过程中不变，如果改变则编译不通过，这样可以保证写出的程序更鲁棒：　

|对象 |目的 |
|:-:|:-:|
|变量 | 希望某个变量不会改变|
|函数参数 | 希望在函数内部变量不会改变|
| 函数返回值| 希望返回对象在后面的使用中不会改变|
| 类的成员函数| 该成员函数内部不能修改对象的成员|


### 赋值运算符重载(Assignment Operators function override)
对象除了进行初始化操作(调用复制构造函数)，还会进行赋值操作(调用的是赋值运算符)。  
- 但是与复制构造函数(自定义了，编译器就不会默认生成)稍有不同，当没有提供以**类或者类的引用**作为参数的赋值运算符函数时，那么编译器还会生成默认的赋值运算符函数进行赋值的工作(也就是复制)。这里注意加粗部分的限制语句，意思是：即使是自定义了赋值运算符函数，如果参数不是类或者类的引用，那么仍会生成。具体参见[一文说尽C++赋值运算符](https://www.cnblogs.com/zpcdbky/p/5027481.html)     

- 赋值运算符函数在编写的时候，首要考虑的就是自赋值的情况，如果是自赋值，就直接返回自身好了；
 
- 默认的赋值运算符函数进行赋值操作，和复制构造函数功能相似，所以同样有浅拷贝和深拷贝的问题，当对象中没有指针，没什么问题，否则赋值就是浅拷贝，两个对象中的指针指向同一块地址。  
     ```cpp
    #include <iostream>
    using namespace std;
     
    class A{
    public:
        int v;
        int *p;
        A();
        A(const A&){};
        ~A();
    };
    
    A::A(){
        p = new int; // 
        v = 1;
    }
    
    A::~A(){
        delete p;
    }
    
    int main(){
        A a1;
        A a2;
        a2.v = 2;
        a2 = a1;
        cout<<a2.v<<endl;   // 1
        cout<<a1.p<<endl;   // 地址和下面的相同，说明两个对象的指针指向同一个内存
        cout<<a2.p<<endl;
    	return 0;       
    }
     ```
最后会爆出下面的错误：free(): double free detected in tcache 2 ，意思同一块内存被释放了2次。  
正确的做法是自己重载赋值运算符函数，具体就是在类中添加该函数，看下面：  

```cpp
class A{
    ...
    A & operator=(const A& scr);
}

A& A::operator=(const A& scr){
    if(this != &scr){       // 如果是自赋值，就返回自身
        v = scr.v;
        *p = *(scr.p);
    }
    return *this;
}
```  
用一个更实际的例子来说明，就是string 类的赋值运算符函数：  

```cpp
#include <iostream>
#include <string>
#include <cstring>
using namespace std;

class String{
private:
    char *p;

public:
    String();
    String(const String&);
    char *operator=(const char *p_scr);
    String &operator=(const String &str);
    const char * c_str(){return p;}
    ~String();
};

String::String():p(NULL){       // 这里给 p 分配了内存空间，只是指向的是 NULL 
}

// 不用判断成员指着变量是否为空，因为还没有初始化，成员指针变量不可能指向任何地址的
String::String(const String& str){
    if (str.p) {    
        p = new char[strlen(str.p) + 1];    // +1 的原因是为 strcpy 函数中的 p 多一个空间来存储结尾符'\0'
        strcpy(p, str.p);
    }
    else{
        p = NULL;
    }
}

String & String::operator=(const String &str){
    if (p == str.p) {       // 需要判断 是否是 自己给自己赋值， 就是 a = a；的情况，如果是，直接返回就好了。
        return *this;
    }
    if (p) {
        delete []p;
    }

    if (str.p) {
        p = new char[strlen(str.p) + 1];    // +1 的原因是为 strcpy 函数中的 p 多一个空间来存储结尾符'\0'
        strcpy(p, str.p);
    }
    else{
        p = NULL;
    }
    return *this;
}

char * String::operator=(const char *p_scr){
    if (p) {            // 如果 p 是非空的(非NULL)，那么就要释放 p 原来指向的空间，因为这个空间是通过 new 在堆上分配的， 而后面 赋值的时候，要根据
                        // p_scr 所指向空间的大小，重新分配内存，如果此处不释放，那么在程序结束之前，就不会释放掉 p 原来指向的内存空间。
        delete []p;
    }
    if(p_scr){
        p = new char[strlen(p_scr) + 1];
        strcpy(p, p_scr);
    }
    else{
        p = NULL;
    }
    return p;
}

String::~String(){
   delete []p; 
}

int main(int argc, char *argv[]){
    String s;
    s = "this is a test";  // 调用的是返回值是 char * 的赋值运算函数
    cout<< s.c_str() <<endl;   //this is a test
    String s1;
    s1 = s;     // 调用的是返回值是 String & 赋值运算符
    cout<<s1.c_str()<<endl;  //this is a test

    return 0;
}
```
- 在编写派生类的赋值运算符函数的时候，不要忘记的基类数据成员的重新赋值，这可以通过调用基类的赋值函数来实现。  
    ```cpp
    class Base{
    private:
        int m_i, m_j;
    
    public:
        Base();
        Base& operator=(const Base& other);
    };
    
    
    Base& Base::operator=(const Base& other){
        if(this != &other){
            m_i = other.m_i;
            m_j = other.m_j;
        }
        return *this;
    }
    
    class Derive:public Base{
    private:
        int m_x, m_y;
    
    public:
        Derive();
        Derive& operator=(const Derive& other);
    };
    
    Derive& Derive::operator=(const Derive& other){
        if(this != &other){
            Base::operator=(other);   // 因为派生类不能访问基类的私有成员，因此不能使用 m_i = other.m_i 来赋值
            m_x = other.m_x;
            m_y = other.m_y;
        }
        return *this;
    }
    ```
