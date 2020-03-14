## 类之间的关系
- 类间关系有复合(包含)和继承，复合涉及到类访问被包含对象的私有变量和函数的问题，引出了 友元(friend) 概念，当然友元也可以泛化为独立的函数与类的关系；  
- 继承考虑到子类与父类的特殊关系，从而引出了一类成员，子类可以内部访问，而子类对象和父类对象外部不可用的成员：protected 成员；  
- 特别说明：对于父类的私有成员，子类也是不可以访问的

### 友元

1. 独立的函数和其他类的成员函数都可以作为类的友元，从而获取使用类中私有变量的权利；
     ```cpp
     class Car;
     
     class Driver{
     private:
         string logo;
     public:
         void ModifyCar(Car * pCar);
     };
     
     class Car{
     private:
         int price;
     public:
         friend int MostExpensiveCar(Car cars[], int total);     // 外部独立函数，可以访问Car的私有成员;
         friend void Driver::ModifyCar(Car *pCar);   // 声明为友元，可以访问 Car 的私有成员，对于公有成员，不用如此声明，就是可以用的。
     };
     
     void Driver::ModifyCar(Car * pCar){
         pCar->price += 100;     //访问了Car 的private 成员
     }
     ```
    **Note：友元只是一种关系说明，并不属于类，所以放在 private 或 public 处说明，都是一样的。**

2. 一个类亦可以作为另一个类的友元，如 类A 是类B 的友元，那么类A可以访问类B的私有成员，反过来B是不可以访问A的私有成员的，友元是单方面的，友元关系更不能传递了；   
    ```cpp
    #include <iostream>
    using namespace std;
    
    class Car{
    private:
        int price;
        friend class Driver;
    public:
        Car(int );
    };
    
    class Driver{
    private:
        int n_type;
    public:
        Car MyCar;
        Driver(int _n_type, int _price);
        void ModifyCar(){
            MyCar.price =+ 10000;
            cout<< MyCar.price <<endl;
        }
    };
    
    Car::Car(int _price):price(_price){
    }
    
    Driver::Driver(int _n_type, int _price):n_type(_n_type), MyCar(_price){
    }
    
    int main(int argc, char *argv[]){
        Driver dr(100, 2333);
        dr.ModifyCar();
        return 0;
    }
    ```
    **说明： Driver 包含了类 Car, 是封闭类，封闭类要考虑被包含类的对象的创建过程，也就是被包含类的构造函数，如果被包含类没有自定义构造函数(使用编译器生成的默认的构造函数)，那么封闭类创建对象的时候，就不用考虑被包含类的生成过程；否则，封闭类的构造函数要给明被包含类的使用的构造函数，否则编译通不过，因为编译器不知道如何生成被包含类的对象；看下面的例子：**
    ```cpp
    #include <iostream>
    using namespace std;
    
    class Car{
    private:
        int price;
        friend class Driver;  // Driver 是 Car 的友元，那么 Driver 的成员函数(private/public)都可以访问 Car 的私有成员
    public:
        Car(int );  // 定义了构造函数，那么在 Driver 类中要给出该类对象的构造过程
    };

    Car::Car(int _price):price(_price){
    }
    
    class Driver{
    private:
        int n_type;
    public:
        Car MyCar;
        Driver(int _n_type, int _price);
        void ModifyCar(){
            MyCar.price =+ 10000;
            cout<< MyCar.price <<endl;
        }
    };
    
    // 此处要给出 MyCar 的初始化过程
    Driver::Driver(int _n_type, int _price):n_type(_n_type), MyCar(_price){ 
    }
    
    int main(int argc, char *argv[]){
        Driver dr(100, 2333);
        dr.ModifyCar();
        return 0;
    }
    ```

### 继承

- 继承有公有继承(public) 和 私有继承(private)，主流是公有继承，这里只讨论公有继承的特性(后面说的继承，都是指公有继承)，对于私有继承，在使用的时候在进行特定的学习。  

- 最先考虑的问题就是子类对象的创建问题：其创建顺序是 先调用基类的构造函数 -> 然后是子类的构造函数。  

- **子类不能访问父类的私有成员，所以在子类的构造函数的时候，想要初始化父类的私有成员，需要使用通过初始化列表来调用父类的构造函数；这个前提是基类的构造函数是有参的，如果无参或者没定义(使用编译器生成默认的)，那么就没有这个问题，这个见第二个例子。**
    
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
    
- 当父类的构造函数是无参或没有定义的时候，创建子类的对象的时候，会调用无参构造函数或者默认的无参构造函数；

    ```cpp
    #include <iostream>
    using namespace std;
    
    class Bug{
    private:
        int nLegs;
        int nColors;
    
    public:
        int type;
        Bug();
        void printValue();
    };
    
    Bug::Bug(){
        nLegs = 0;
        nColors = 0;
    }
    
    void Bug::printValue(){
        cout<< nColors <<endl;
        cout<< nLegs <<endl;
    }
    // 公有继承
    class FlyBug:public Bug{
    private:
        int nWings;
    public:
        FlyBug();
        void printValue();
    };
    
    FlyBug::FlyBug(){
        nWings = 0;
    }
    
    void FlyBug::printValue(){
        Bug::printValue();
        cout<< nWings <<endl;
    }
    
    int main(int argc, char *argv[]){
        FlyBug fb;
        fb.printValue();
        return 0;
    }
    ```



