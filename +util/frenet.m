function [T,N,B,k,t] = frenet(x,y,z)
% FRENET - Frenet-Serret Space Curve Invariants
%   
%   [T,N,B,k,t] = frenet(P);
%   [T,N,B,k,t] = frenet(x,y);
%   [T,N,B,k,t] = frenet(x,y,z);
% 
%   Returns the 3 vector and 2 scaler invariants of a space curve defined
%   by vectors x, y and z. If z is omitted then the curve is only a 2D,
%   but the equations are still valid. The points can either be given as
%   three paramters x, y, [z], or as a single matrix P = [x, y, z], with
%   the z dimension being optional.
% 
%    _    r'
%    T = ----  (Tangent)
%        |r'|
% 
%    _    T'
%    N = ----  (Normal)
%        |T'|
%    _   _   _
%    B = T x N (Binormal)
% 
%    k = |T'|  (Curvature)
% 
%    t = dot(-B',N) (Torsion)
% 
% 
%    Example:
%    theta = 2*pi*linspace(0,2,100);
%    x = cos(theta);
%    y = sin(theta);
%    z = theta/(2*pi);
%    [T,N,B,k,t] = frenet(x,y,z);
%    line(x,y,z), hold on
%    quiver3(x,y,z,T(:,1),T(:,2),T(:,3),'color','r')
%    quiver3(x,y,z,N(:,1),N(:,2),N(:,3),'color','g')
%    quiver3(x,y,z,B(:,1),B(:,2),B(:,3),'color','b')
%    legend('Curve','Tangent','Normal','Binormal')
% 
% 
% See also: GRADIENT

if nargin == 1
    if size(x, 2)==2
        y = x(:, 2);
        x = x(:, 1);
        z = zeros(size(x));
    else
        z = x(:, 3);
        y = x(:, 2);
        x = x(:, 1);
    end
elseif nargin == 2
    z = zeros(size(x));
end



% SPEED OF CURVE
dx = gradient(x);
dy = gradient(y);
dz = gradient(z);
dr = [dx dy dz];

ddx = gradient(dx);
ddy = gradient(dy);
ddz = gradient(dz);
ddr = [ddx ddy ddz];



% TANGENT
T = dr./mag(dr,3);


% DERIVATIVE OF TANGENT
dTx =  gradient(T(:,1));
dTy =  gradient(T(:,2));
dTz =  gradient(T(:,3));

dT = [dTx dTy dTz];


% NORMAL
N = dT./mag(dT,3);
% BINORMAL
B = cross(T,N);
% CURVATURE
% k = mag(dT,1);
k = mag(cross(dr,ddr),1)./((mag(dr,1)).^3);

% DERIVATIVE OF BINORMAL
dBx = gradient(B(:, 1));
dBy = gradient(B(:, 2));
dBz = gradient(B(:, 3));
dB = [dBx dBy dBz];

% TORSION
% t = mag(-dB,1);
t = dot(-dB, N, 2);

% 
% % DERIVATIVE OF NORMAL
% dNx = gradient(N(:, 1));
% dNy = gradient(N(:, 2));
% dNz = gradient(N(:, 3));
% dN = [dNx dNy dNz];
% 
% plot(abs(dN + k.*T - t.*B));




function N = mag(T,n)
% MAGNATUDE OF A VECTOR (Nx3)
%  M = mag(U)
N = sum(abs(T).^2,2).^(1/2);
d = find(N==0);
N(d) = eps*ones(size(d));
N = N(:,ones(n,1));
