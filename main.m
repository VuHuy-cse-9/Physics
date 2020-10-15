%Kich thuoc cua mang thuy tinh. 3x3
n = 3;
h = 3.92;
deNan = 1;
sizeRow = 0;
count = 0;
%Tao va luu du lieu vao file data.mat
load data.mat %h_coor, type 
input = table2array(input);
count = 0;
%Sorting for type
%Calculate distance
numberOfHCoordinate = size(input(:,1)); 
for i=1:2:(numberOfHCoordinate(1,1))
    count = count + 1;
    deNan = 1;
    h_coor = input(i:i+1,:);
    sizeRow = size(h_coor(1,:));
    while(true)
        if (deNan == sizeRow(1,2))
            break;
        end
        if (isnan(h_coor(1,deNan))) 
            h_coor(:, deNan:sizeRow(1,2)) = [];
            break;
        end
        deNan = deNan + 1;
    end
    

output1 = caldistance(h_coor, h, n); %output include all pair of distance and its label.

%Eliminate pair that have distance > max or < min type's distance.

%Count Pt.
output2 = countPt(h_coor, n, h);

%checkType
output(count,1:7) = checkType(output1,output2,type); %Result.
end

sizename = size(name(:,1));
output = array2table(output);
output.Properties.VariableNames = {'type1','type2','type3','type4','type5','type6','type7'};
name.Properties.VariableNames = {'CaseID'};
output = [name, output];
writetable(output, 'output.csv');