## 类之间的关系


### 封闭类

其他类的对象作为该类的成员变量，那么这个类就叫做封闭类。

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
    friend void Driver::ModifyCar(Car *pCar);   // 声明为友元，可以访问 Car 的私有成员，对于公有成员，不用如此声明，就是可以用的。
};

void Driver::ModifyCar(Car * pCar){
    pCar->price += 100;
}
    ```

### 继承




