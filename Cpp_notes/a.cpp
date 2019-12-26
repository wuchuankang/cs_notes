#include <iostream>
#include <cstring>
#include <string>

using namespace std;

void MyPrint(string &p){
    p = "this";
    cout<<p<<endl;
}

int main(int argc, char * argv[]){
    string s;
    s = "is";
    char *p;
    char a[10] = "this";
    s = a;
    cout<<strlen(a)<<endl;
    cout<<sizeof(a)<<endl;

    int b[] = {1,2,3};
    cout<<s<<endl;

    return 0;
}
