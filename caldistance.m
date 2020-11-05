function output = caldistance(hcoor, h, n)
    %n is size of lattice 
    k = h / 2;
    sizehcoor = size(hcoor(1,:));
    digits(2);
    for index=1:sizehcoor(1,2)
    for i = 1:sizehcoor(1,2)
        distance0 = sqrt((hcoor(1,index) - hcoor(1,i))^2 + (hcoor(2,index) - hcoor(2,i))^2);
        distancet = sqrt((hcoor(1,index) - hcoor(1,i))^2 + (hcoor(2,index) - hcoor(2,i)- 2*n*k)^2);
        distanced = sqrt((hcoor(1,index) - hcoor(1,i) - 2*n*k)^2 + (hcoor(2,index) - hcoor(2,i) - 2*n*k)^2);
        distancel = sqrt((hcoor(1,index) - hcoor(1,i) - 2*n*k)^2 + (hcoor(2,index) - hcoor(2,i))^2);
        %Eliminate that not interval of type distance.
        output(index,i) =   round(distance0, 9);
        output(index,i+sizehcoor(1,2)) = round(distancet, 9);
        output(index,i+2*sizehcoor(1,2)) = round(distanced, 9);
        output(index,i+3*sizehcoor(1,2)) = round(distancel, 9);
    end
    end
end
