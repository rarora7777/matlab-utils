function M = stencilToMat1D(stencil, n, closed)
    
    s = numel(stencil);
    assert(mod(s, 2) == 1);
    
    if (size(stencil, 1) == 1)
        stencil = stencil';
    end
    
    tri = zeros(s*n, 3);
    
    range = (-floor(s/2):floor(s/2))';
    
    for i=0:n-1
        tri(s*i + (1:s), 1) = i+1;
        if closed
            tri(s*i + (1:s), 2) = mod(i + range, n) + 1;
        else
            tri(s*i + (1:s), 2) = i + range + 1;
        end
            tri(s*i + (1:s), 3) = stencil;
    end
    
    tri(tri(:, 2)<=0, :) = [];
    tri(tri(:, 2)>n, :) = [];
    
    M = sparse(tri(:, 1), tri(:, 2), tri(:, 3), n, n);
end