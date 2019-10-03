function fig(titleBarHeight)
    openFigs = findobj('type', 'figure');

    openFigCount = length(openFigs);

    openFigCount = mod(openFigCount, 4);
    
    if (nargin == 0)
        titleBarHeight = 80;
    end
    
    if openFigCount == 0
        defaultPosition = get(0, 'defaultFigurePosition');
    else
        pos = zeros(openFigCount, 2);
        for i=1:openFigCount
            pos(i, :) = openFigs(i).Position([1, 2]);
        end

        defaultPosition = [min(pos(:, 1)), max(pos(:, 2)), openFigs(1).Position(3:4)];
    end
    
    switch(openFigCount)
        case 0
            figure('Renderer', 'painters', 'Position', defaultPosition);
        case 1
            lOffset = openFigs(1).Position(3);
            figure('Renderer', 'painters', 'Position', defaultPosition + [lOffset 0 0 0]);
        case 2
            bOffset = defaultPosition(4) + titleBarHeight;
            figure('Renderer', 'painters', 'Position', defaultPosition + [0 -bOffset 0 0]);
        case 3
            lOffset = defaultPosition(3);
            bOffset = defaultPosition(4) + titleBarHeight;
            figure('Renderer', 'painters', 'Position', defaultPosition + [lOffset -bOffset 0 0]);
    end
end