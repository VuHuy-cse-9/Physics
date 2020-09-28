function type = sorting(type)
    sizeType = size(type(1,:));
    for i= 1: sizeType(1,2)
        for j = i + 1:sizeType(1,2)
            if (type(1,i) < type(1,j))
                t = type(:,i);
                type(:,i) = type(:,j);
                type(:,j) = t;
            end
        end
    end
end

