#include <iostream>
#include <cassert>

using namespace std;

char *strcpy(char *strDest, const char *strSrc){
    assert((strDest != NULL) && (strSrc != NULL));

    char *adress = strDest;

    while((*strDest++ = *strSrc++) != '\0');

    return adress;
}

int main(int argc, char * argv[]){

    char a[10] = "this";
    char *p;
    p = NULL;
    strcpy(p, a);


    return 0;
}
