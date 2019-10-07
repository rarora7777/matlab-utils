function Xm = circmeanpol(X, k)
%%
% Returns rolling (moving) average of the vectors contained in X assuming
% that X has the topology of a circle (circular moving average).
% X is an n x dim sized array, where dim must be 2 or 3
% The size of the avergaing window is 2*k+1
% WARNING: This function assumes that X(1, :) and X(end, :) are the same!

    dim = size(X, 2);
    assert(dim==2 || dim==3);
    
    circmean = @(X, k) movmean([X(end-1:-1:end-k, :); X; X(2:k+1, :)], 2*k+1, 1, 'Endpoints', 'discard');
    
    if dim==2
        [t, r] = cart2pol(X(:, 1), X(:, 2));
    elseif dim==3
        [t, r, z] = cart2pol(X(:, 1), X(:, 2), X(:, 3));
    end
    
    t = circmean(t, k);
    r = circmean(r, k);
    
    if dim==3
        z = circmean(z, k);
    end
    
    if dim==2
        [x, y] = pol2cart(t, r);
        Xm = [x, y];
    elseif dim==3
        [x, y, z] = pol2cart(t, r, z);
        Xm = [x, y, z];
    end
end
