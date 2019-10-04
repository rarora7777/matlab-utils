function fig(gridArea, gridSize)
%% Opens figures in a 2x2 grid in the right half of the screen
% Inputs 
% gridArea: string describing where should the grid be located
% (TODO, default: 'rhalf': right half of screen with MATLAB window)
% gridSize: 2-element vector defining the number of rows and columns in the
% grid
% (TODO, default: [2 2])

    if nargin >=1 && ~strcmp(gridArea, 'rhalf')
        error('util:NotYetImplementedError', 'Functionality not available yet.');
    end
    
    if nargin >=2 && (numel(gridSize) ~= 2 || (gridSize(1) ~= 2 || gridSize(2) ~= 2))
        error('util:NotYetImplementedError', 'Functionality not available yet.');
    end
        
    openFigs = findobj('type', 'figure');

    openFigCount = length(openFigs);
    
    pos = zeros(openFigCount, 2);
    gridFig = false(openFigCount, 1);
    for i=1:openFigCount
        if ischar(openFigs(i).UserData) && contains(openFigs(i).UserData, 'grid')
            pos(i, :) = openFigs(i).OuterPosition([1, 2]);
            gridFig(i) = true;
        end
    end

    pos = pos(gridFig, :);
    firstFigIdx = find(gridFig, 1);
    openFigCount = sum(gridFig);

    if openFigCount == 0
        screenSize = get(0, 'ScreenSize');
        defaultPosition = [screenSize(3)/2, screenSize(4)/2, screenSize(3)/4, screenSize(4)/2];
    else
        defaultPosition = [min(pos(:, 1)), max(pos(:, 2)), openFigs(firstFigIdx).OuterPosition(3:4)];
    end
    
    switch(mod(openFigCount, 4))
        case 0
            figure('OuterPosition', defaultPosition, 'UserData', ['grid', num2str(openFigCount+1)]);
        case 1
            lOffset = defaultPosition(3);
            figure('OuterPosition', defaultPosition + [lOffset 0 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
        case 2
            bOffset = defaultPosition(4);
            figure('OuterPosition', defaultPosition + [0 -bOffset 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
        case 3
            lOffset = defaultPosition(3);
            bOffset = defaultPosition(4);
            figure('OuterPosition', defaultPosition + [lOffset -bOffset 0 0], 'UserData', ['grid', num2str(openFigCount+1)]);
    end
end
