function output = caldistance(hcoor, a, n)
    %n is size of lattice 
    a = a / 2;
    sizehcoor = size(hcoor(1,:));
    for index=1:sizehcoor(1,2)
    for i = 1:sizehcoor(1,2)
        distance0 = sqrt((hcoor(1,index) - hcoor(1,i))^2 + (hcoor(2,index) - hcoor(2,i))^2)*a;
        distancet = sqrt((hcoor(1,index) - hcoor(1,i))^2 + (hcoor(2,index) - hcoor(2,i)- 2*n)^2)*a;
        distanced = sqrt((hcoor(1,index) - hcoor(1,i) - 2*n)^2 + (hcoor(2,index) - hcoor(2,i) - 2*n)^2)*a;
        distancel = sqrt((hcoor(1,index) - hcoor(1,i) - 2*n)^2 + (hcoor(2,index) - hcoor(2,i))^2)*a;
        %Eliminate that not interval of type distance.
        output(index,i) = distance0;
        output(index,i+4) = distancet;
        output(index,i+8) = distanced;
        output(index,i+12) = distancel;
    end
    end
end
