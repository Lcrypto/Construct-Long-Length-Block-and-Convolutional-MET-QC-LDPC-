function [cycles4] = get4cyclesByProto(proto)
[rows, cols] = size(proto);
cycles4 = 0;
persistent cost;
if isempty(cost)
    cost = ones(1, 100);
    for i=1:length(cost)
        cost(i) = 1.0 / (i * i);
    end
end

for r1=1:rows
    for c1 = 1:cols
        if (proto(r1, c1) == 0)
            continue;
        end
        for r2 = r1 + 1:rows
            if (proto(r2, c1) == 0)
                continue;
            end        
            for c2 = c1 + 1:cols
                if ((proto(r1, c2)) && (proto(r2, c2)))
                    emd = sum(proto(:, c1)) + sum(proto(:, c2)) - sum(proto(:, c1).*proto(:, c2)) * 2;
                    ace = sum(proto(:, c1)) + sum(proto(:, c2)) - 4;
                    cycles4 = cycles4 + cost(ace + 1);
                end                
            end
        end        
    end
end
end