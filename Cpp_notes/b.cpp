#include <iostream>
using namespace std;
 

class A{
private:
    

public:
    int v;
    int *p;
    A();
    A(const A&);
    ~A();
};

A::A(){
    p = new int;
    v = 1;
}

A::A(const A&){
    
}

A::~A(){
    delete p;
    
}


int main(){
    A a1;
    A a2;
    a2.v = 2;
    a2 = a1;
    cout<<a2.v<<endl;
    cout<<a1.p<<endl;
    cout<<a2.p<<endl;
    

	return 0;
}
