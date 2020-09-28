function output = checkType(distance , countPt, type)
    sizeType = size(type(1,:));
    sizeDistanceRow = size(distance(1,:)); %Pt and distance have same meaning matrix
    sizeDistanceCol = size(distance(:,1));
    
    output = zeros(1,sizeType(1,2));
    for i = 1:sizeDistanceCol(1,1)
        for j = 1:sizeDistanceRow(1,2)
            for k=1:sizeType(1,2)
                %Eliminate 2 duplicate's pairs.
                if (i == 1 && j == 4) 
                    continue;
                end
                if (i == 2 && j == 3)
                    continue;
                end
                if (i == 1 && j == 2)
                    continue;
                end
                if (i == 3 && j == 4)
                    continue;
                end
                if (i == 1 && j == 3)
                    continue;
                end
                if (i == 2 && j == 4)
                    continue;
                end
                %round exactly 2 digits in decimal.
                if (round(distance(i,j),2) == type(1,k) && countPt(i,j) == type(2,k))
                    output(1,k) = output(1,k) + 1;
                end
            end
        end
    end
end

