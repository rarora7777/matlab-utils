function fig(titleBarHeight)
    openFigs = findobj('type', 'figure');

    openFigCount = length(openFigs);
    
    pos = zeros(openFigCount, 2);
    gridFig = false(openFigCount, 1);
    for i=1:openFigCount
        if ischar(openFigs(i).UserData) && contains(openFigs(i).UserData, 'grid')
            pos(i, :) = openFigs(i).Position([1, 2]);
            gridFig(i) = true;
        end
    end

    pos = pos(gridFig, :);
    firstFigIdx = find(gridFig, 1);
    openFigCount = sum(gridFig);

    if (nargin == 0)
        titleBarHeight = 80;
    end
    
    if openFigCount == 0
        screenSize = get(0, 'ScreenSize');
        defaultPosition = [screenSize(3)/2, screenSize(4)/2, screenSize(3)/4, screenSize(4)/2 - titleBarHeight];
    else
        defaultPosition = [min(pos(:, 1)), max(pos(:, 2)), openFigs(firstFigIdx).Position(3:4)];
    end
    
    switch(mod(openFigCount, 4))
        case 0
            figure('Position', defaultPosition, 'UserData', ['grid', num2str(openFigCount+1)]);
        case 1
            lOffset = openFigs(firstFigIdx).Position(3);
            figure('Position', defaultPosition + [lOffset 0 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
        case 2
            bOffset = defaultPosition(4) + titleBarHeight;
            figure('Position', defaultPosition + [0 -bOffset 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
        case 3
            lOffset = defaultPosition(3);
            bOffset = defaultPosition(4) + titleBarHeight;
            figure('Position', defaultPosition + [lOffset -bOffset 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
    end
end
