%Kich thuoc cua mang thuy tinh. 3x3
n = 3;
a = 3.9242;
%Tao va luu du lieu vao file data.mat
load data.mat %h_coor, type 

%Sorting for type

%Calculate distance:
output1 = caldistance(h_coor, a, n); %output include all pair of distance and its label.

%Eliminate pair that have distance > max or < min type's distance.

%Count Pt.
output2 = countPt(h_coor, n);

%checkType
output = checkType(output1,output2,type); %Result.