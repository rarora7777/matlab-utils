function copyaxesprops(source, destination, respectPropertyModes)
%% 
% copyaxesprops - copy a handle object axes inpt
% 
% copyaxesprops(SOURCE, DESTINATION) - copy axes properties from SOURCE to
% DESTINATION
% copyaxesprops(SOURCE, DESTINATION, true) - copy axes properties from 
% SOURCE to DESTINATION while respecting *LimMode properties. This ensures 
% that properties chosen automatically by MATLAB for the SOURCE axes will 
% be automatically chosen for the DESTINATION as well.
% EXAMPLE: 
%   plot([1:0.1:2*pi], sin([1:0.1:2*pi]));
%   title('sine function')
%   xlabel('x')
%   ylabel('sin(x)')
%   ax = gca;
% 
%   figure;
%   plot([1:0.1:2*pi], 0.5*sin([1:0.1:2*pi]));
%   copyaxesprops(ax, gca)
%   ylabel('sin(x)/2')
% 
% original author: Mar Callau-Zori
% PhD student - Universidad Politecnica de Madrid
% 
% version: 1.2, December 2011
% 
% the original version copies the actual plots as well
% https://www.mathworks.com/matlabcentral/fileexchange/34314-copyaxes
% License for the original script:
% 
% % Copyright (c) 2011, Mar Callau-Zori
% All rights reserved.
% 
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% * Neither the name of Universidad Politécnica de Madrid nor the names of its
%   contributors may be used to endorse or promote products derived from this
%   software without specific prior written permission.
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%%
% modified by: Rahul Arora, University of Toronto
% December 2017

    title = copyobj(get(source, 'Title'), destination);
    set(destination, 'Title', title);

    xlabel = copyobj(get(source, 'XLabel'), destination);
    set(destination, 'XLabel', xlabel);

    ylabel = copyobj(get(source, 'YLabel'), destination);
    set(destination, 'YLabel', ylabel);

    zlabel = copyobj(get(source, 'ZLabel'), destination);
    set(destination, 'ZLabel', zlabel);
    
    properties_str = {
        'Units'
        'ActivePositionProperty'
        'ALim'
%         'ALimMode'
        'AmbientLightColor'
        'Box'
        'BoxStyle'
        'CameraPosition'
        'CameraPositionMode'
        'CameraTarget'
        'CameraTargetMode'
        'CameraUpVector'
        'CameraUpVectorMode'
        'CameraViewAngle'
        'CameraViewAngleMode'
        'CLim'
%         'CLimMode'
        'Color'
        'CurrentPoint'
        'ColorOrder'
        'ColorOrderIndex'
        'DataAspectRatio'
        'DataAspectRatioMode'
        'FontAngle'
        'FontName'
        'FontSize'
        'FontSmoothing'
        'FontUnits'
        'FontWeight'
        'GridAlpha'
        'GridAlphaMode'
        'GridColorMode'
        'GridLineStyle'
        'LabelFontSizeMultiplier'
        'Layer'
        'LineStyleOrder'
        'LineStyleOrderIndex'
        'LineWidth'
        'MinorGridAlpha'
        'MinorGridAlphaMode'
        'MinorGridColorMode'
        'MinorGridLineStyle'
        'NextPlot'
        'OuterPosition'
        'PlotBoxAspectRatio'
        'PlotBoxAspectRatioMode'
        'Projection'
        'Position'
        'SortMethod'
        'TickLabelInterpreter'
        'TickLength'
        'TickDir'
        'TickDirMode'
        'TightInset'
        'TitleFontSizeMultiplier'
        'TitleFontWeight'
        'View'
        'XColor'
        'XDir'
        'XGrid'
        'XAxisLocation'
        'XLim'
%         'XLimMode'
        'XMinorGrid'
        'XMinorTick'
        'XScale'
        'XTick'
        'XTickLabel'
        'XTickLabelMode'
        'XTickLabelRotation'
        'XTickMode'
        'YColor'
        'YDir'
        'YGrid'
        'YAxisLocation'
        'YLim'
%         'YLimMode'        
        'YMinorGrid'
        'YMinorTick'
        'YScale'
        'YTick'
        'YTickLabel'
        'YTickLabelMode'
        'YTickLabelRotation'
        'YTickMode'
        'ZColor'
        'ZDir'
        'ZGrid'
        'ZLim'
%         'ZLimMode'
        'ZMinorGrid'
        'ZMinorTick'
        'ZScale'
        'ZTick'
        'ZTickLabel'
        'ZTickLabelMode'
        'ZTickLabelRotation'
        'ZTickMode'
        'BeingDeleted'
        'ButtonDownFc'
        'Clipping'
        'CreateFcn'
        'DeleteFcn'
        'BusyAction'
        'HandleVisibility'
        'HitTest'
        'Interruptible'
        'Selected'
        'SelectionHighlight'
        'Tag'
        'Type'
        'UIContextMenu'
        'UserData'
        'Visible'
    };
                    
    mode_properties_str = {
        'ALimMode'
%         'CameraPositionMode'
%         'CameraTargetMode'
%         'CameraUpVectorMode'
%         'CameraViewAngleMode'
        'CLimMode'
%         'DataAspectRatioMode'
%         'PlotBoxAspectRatioMode'
%         'TickDirMode'
        'XLimMode'
%         'XTickLabelMode'
%         'XTickMode'
        'YLimMode'
%         'YTickLabelMode'
%         'YTickMode'
        'ZLimMode'
%         'ZTickLabelMode'
%         'ZTickMode'
    };
                    
    if nargin > 2 && respectPropertyModes == true
        properties_str = [properties_str; mode_properties_str];
    end
    
    for i=1:length(properties_str)
        try
            set(destination, properties_str{i}, get(source, properties_str{i}));
        catch e
            if ~strcmpi(e.identifier, 'MATLAB:hg:propswch:FindObjFailed') && ...
               ~strcmpi(e.identifier, 'MATLAB:hg:g_object:MustBeInSameFigure') && ...
               ~strcmpi(e.identifier, 'MATLAB:class:SetProhibited')
                     rethrow(e);
            end
        end
    end
end
