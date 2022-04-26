clc; clear;
x_init=1;
x=x_init;
f=5*x^4-1;
m=100;
h=1/m;
f_x=(5*(x+h)^4-5*(x-h)^4)/(2*h);
f_xx=(5*(x+h)^4+5*(x-h)^4-2*(5*x^4))/h^2;
a=(-1)*f/f_x;
aa=(-1)*f_x/f_xx;

for i=1:500
    x=x+aa;
    f=5*x^4-1;
    f_x=(5*(x+h)^4-5*(x-h)^4)/(2*h);
    f_xx=(5*(x+h)^4+5*(x-h)^4-2*(5*x^4))/h^2;
    aa=(-1)*f_x/f_xx;
    x
    f
end