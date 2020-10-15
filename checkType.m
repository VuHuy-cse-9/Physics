function output = checkType(distance , countPt, type)
    sizeType = size(type(1,:));
    sizehcoor = size(distance(:,1));
    output = zeros(1,sizeType(1,2));
    for n=0:3
        for i = 1:sizehcoor(1,1)
            if (n == 0) 
                j = i;
            else
                j = 1;
            end
            while(j <= sizehcoor(1,1))
                for k=1:sizeType(1,2)                  
                    %round exactly 2 digits in decimal.
                    if (round(distance(i,j+sizehcoor(1,1)*n),2) == type(1,k) && countPt(i,j+sizehcoor(1,1)*n) == type(2,k))
                        output(1,k) = output(1,k) + 1;
                    end
                end
                j = j + 1;
            end
        end
    end
end

