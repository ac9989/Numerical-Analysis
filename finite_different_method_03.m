clc; clear;
init=[5,5];
x=init(1);
y=init(2);
f=5*x^4+4*x^2*y-x*y^3+4*y^4-x;
m=100;
h=1/m;
a=0;
f_x=(5*(x+h)^4+4*(x+h)^2*y-(x+h)*y^3+4*y^4-(x+h))/h;
f_y=(5*x^4+4*x^2*(y+h)-x*(y+h)^3+4*(y+h)^4-x)/h;
g=5*(x+a*f_x)^4+4*(x+a*f_x)^2*(y+a*f_y)-(x+a*f_x)*(y+a*f_y)^3+4*(y+a*f_y)^4-(x+a*f_x);

a_p=a+h;
a_m=a-h;
g_p=5*(x+a_p*f_x)^4+4*(x+a_p*f_x)^2*(y+a_p*f_y)-(x+a_p*f_x)*(y+a_p*f_y)^3+4*(y+a_p*f_y)^4-(x+a_p*f_x);
g_m=5*(x+a_m*f_x)^4+4*(x+a_m*f_x)^2*(y+a_m*f_y)-(x+a_m*f_x)*(y+a_m*f_y)^3+4*(y+a_m*f_y)^4-(x+a_m*f_x);

a=a-((h*(g_p-g_m))/2*(g_p+g_m-2*g));

for i=1:500
    x=x+a;
    y=y+a;
    f_x=(5*(x+h)^4+4*(x+h)^2*y-(x+h)*y^3+4*y^4-(x+h))/h;
    f_y=(5*x^4+4*x^2*(y+h)-x*(y+h)^3+4*(y+h)^4-x)/h;
    g=5*(x+a*f_x)^4+4*(x+a*f_x)^2*(y+a*f_y)-(x+a*f_x)*(y+a*f_y)^3+4*(y+a*f_y)^4-(x+a*f_x);
    a=a-((h*(g_p-g_m))/2*(g_p+g_m-2*g));
    x
    y
end