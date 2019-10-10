function rho = injnnsearch(Y, X)
    m = size(X, 1);
    n = size(Y, 1);
    
    [M, D] = knnsearch(Y, X);
    M(1) = 1;
    M(m) = n;
    D([1, m]) = vecnorm(Y(M([1, m]), :) - X([1, m], :), 2, 2);
    
    [~, idxD] = sort(D);
%     invIdxD(idxD) = 1:length(idxD);
    
    unused = true(m, 1);
    
    rho = zeros(m, 1);
    
    rho(1) = 1;
    rho(m) = n;
    
    unused(1) = false;
    unused(m) = false;
    
    while(true)
        i = idxD(find(unused(idxD), 1));
        if isempty(i)
            break;
        end
        
        r = find(~unused(1:(i-1)), 1, 'last');
        s = i + find(~unused((i+1):end), 1);
        
        if rho(r) < M(i) && rho(s) > M(i)
            unused(i) = false;
            rho(i) = M(i);
            fprintf('(i, M(i) = (%d, %d)\n', i, M(i));
        else
            break;
        end
    end
    
    fprintf('# Unassigned matches : %d\n', sum(unused));
    used = find(~unused);
    for i=1:length(used)-1
        idx0 = used(i);
        idx1 = used(i+1);
        
        rho(idx0:idx1) = round(linspace(rho(idx0), rho(idx1), idx1 - idx0 + 1));
    end
end
