function match = injnnsearch1D(Y, X, closed)
%% Injective nearest-neighbours matching
% Computes an injective matching from X to Y by using
% [Bonneel and Coeurjolly 2019, Algorithm 1]
% https://dl.acm.org/citation.cfm?id=3323021
% X and Y are both sorted 1D sequences (m x 1 and n x 1 matrices)
% Parameters use MATLAB's knnsearch convention: destination is specified
% first, source second.

    if (nargin < 3)
        closed = false;
    end

    m = size(X, 1);
    n = size(Y, 1);
    
    assert(n >= m);
    assert(size(X, 2) == size(Y, 2) == 1);
    assert(all(diff(X) >= 0) && all(diff(Y) >= 0));
    
    if (m==n)
        match = (1:m)';
        return;
    end

    t = knnsearch(Y, X);    
    match = zeros(m, 1);
    
    match(1) = t(1);
    
    if (closed)
        match(m) = n;
        m = m - 1;
        t(t==n) = 1;
    end

    function [R, S] = find_rs()
        S = match(1) - 1;
        del = diff(match(1:m0));
        R = find(del > 1, 1, 'last');
        if numel(R)
            S = match(R+1) - 1;
        else
            R = 1;
        end
    end

    for m0 = 1:m-1
       if t(m0+1) > match(m0)
           match(m0+1) = t(m0+1);
       else
           [r, s] = find_rs();
           
           if s > 0
               w1 = sum(sum((X(r:m0, :) - Y(match(r:m0)-1, :)).^2)) + sum((X(m0+1, :) - Y(match(m0), :)).^2);
               w2 = sum(sum((X(r:m0, :) - Y(match(r:m0), :)).^2)) + sum((X(m0+1, :) - Y(match(m0)+1, :)).^2);
           else
               % When s is undefined, skip weight computation (w1 cannot be
               % computed anyway) and go directly to case 2.
               w1 = 0;
               w2 = -1;
           end
           
           if w1 < w2
               % Case 1
               match(m0+1) = match(m0)+1;
               match(r:m0) = s:(match(m0)-1);
           else
               % Case 2
               match(m0+1) = match(m0) + 1;
           end
       end
    end
    
    disp([X, Y(match, :)]);
end
