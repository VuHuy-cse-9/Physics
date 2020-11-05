function output = countPt(h_coor, nlattice, h) %nlattice: mang thuy tinh nlatticexnlattice
    %I assume h_coor is standard index.
    b = h / 2; % b = k
    sizehcoor = size(h_coor(1,:));
    for i = 1:sizehcoor(1,2)
        for j = 1:sizehcoor(1,2)
            for k = 1:4 %1 -> 4 <=> in, top, diagonal,right point
                x_coor = h_coor(1,j);
                y_coor = h_coor(2,j);
                numberOfPt = 0;
                if (k == 2) %Top
                    y_coor = y_coor + 2*nlattice*b;
                elseif (k == 3) %Diagonal
                    x_coor = x_coor + 2*nlattice*b;
                    y_coor = y_coor + 2*nlattice*b;
                elseif (k == 4) %Right
                    x_coor = x_coor + 2*nlattice*b;
                end
                %Line equation: (x-xo)(y1-y0) = (y-y0)(x1-x0)
                %%%%x0 < 1 + n*0.5 < x1
                %%%%y0 < 1 + m*0.5 < y1
                %%%%n.m e N
                x0 = h_coor(1, i);
                x1 = x_coor;
                y0 = h_coor(2, i);
                y1 = y_coor;
                if (x0 == x1 && y0 == y1) 
                    continue;
                end
                if (x0 > x1) 
                    startX = x1;
                    stpX = x0;
                else
                    startX = x0;
                    stpX = x1;
                end
                
                if (y0 > y1) 
                    startY = y1;
                    stpY = y0;
                else
                    startY = y0;
                    stpY = y1;
                end
                for n = ceil(startX/b):1:floor(stpX/b)
                    for m = ceil(startY/b):1:floor(stpY/b)
                        if ((mod(n,2) == 0 && mod(m,2) == 0) ||(mod(n,2) == 1 && mod(m,2) == 1))
                            if (round((n*1.96 - x0)*(y1-y0) - (m*1.96-y0)*(x1-x0),9) == 0)
                                numberOfPt = numberOfPt + 1;
                            end
                        end 
                    end
                end
                output(i, j + (k-1)*sizehcoor(1,2)) = numberOfPt;
            end
        end
    end
end

