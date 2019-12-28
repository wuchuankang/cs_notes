#include <iostream>

using namespace std;


class Complex{
private:
    double real, imag;

public:
    Complex();
    Complex (double r);
    Complex (double r, double i);
    Complex (Complex c1, Complex c2);
    virtual ~Complex ();
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


int main(int argc, char *argv[]){
    Complex c0;
    Complex c00();
    Complex c1(2, 3);
    Complex c2(4);
    Complex c3(c1, c2);
    Complex *pc = new Complex(4, 5);
    
    return 0;
}
