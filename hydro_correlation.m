%%%input parameters
a=3.9242;
b=a/2;
c=a/4;
pt_coor=[0,0;     a,0;       2*a,0;... 
         b,b;     b+a,b;     b+2*a,b;... 
         0,a;     a,a;       2*a,a;...
         b,b+a;   b+a,b+a;   b+2*a,b+a;...
         0,2*a;   a,2*a;     2*a,2*a;...
         b,b+2*a; b+a,b+2*a; b+2*a,b+2*a];

%%% for example, 3 hydrogen atoms case
h_coor=[c,c;...
        c+b,a+c;...
        c+a,c];
    
%%define correlation type=[distance of 2 hydro, number of pt among 2 hydro]
type1=[1.96, 0];
type2=[2.77, 1];
type3=[2.77, 0];
type4=[3.92, 0];
type5=[4.39, 0];
type6=[5.55, 0];
type7=[5.55, 1];