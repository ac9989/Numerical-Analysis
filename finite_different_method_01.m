clc; clear;
x_init=1;
x=x_init;
f=5*x^4-1;
m=100;
h=1/m;
f_x=(5*(x+h)^4-5*(x-h)^4)/(2*h);

a=(-1)*f/f_x;

for i=1:50
    x=x+a;
    f=5*x^4-1;
    f_x=(5*(x+h)^4-5*(x-h)^4)/(2*h);
    a=(-1)*f/f_x;
    x
    f
end

