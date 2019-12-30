#include <iostream>
using namespace std;

int gl = 2;
int & foo(){
    gl = 1;
    return gl;
}

int & fun(int &a){
    a += 1;
    return a;
}

int main(int argc, char*argv[]){
    foo() = 4;
    cout<<gl<<endl;
    int a = 2;
    fun(a);
    cout<<a<<endl;
    int b = foo();
    cout<<b<<endl;
    cout<<gl<<endl;

    return 0;
}
