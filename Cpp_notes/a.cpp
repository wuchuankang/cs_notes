#include <iostream>

using namespace std;

class A{
private:

public:
    int v;
    A(int n){v = n;};
    A(const A&);
    ~A(){};
};

A::A(const A&a){
    v = 8;
    cout<<"call copy constructor"<<endl;
}

A Foo(){
    A b(4);
    return b;
}

int main(int argc, char *argv[]){
    //cout<<Foo().v<<endl;
    A a(1);
    A b(a);
    A c = a;
    cout<<b.v<<endl;

    return 0;
}
