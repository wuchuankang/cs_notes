#include "../include/my_operator.h"
#include <iostream>

using namespace std;

int main(){
    int a = 2;
    int b = 3;
    int c;
    c = add(a, b);
    cout<<"result: "<<c<<endl;
    return c;
}
