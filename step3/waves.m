function waves
%TODO : Set up a mesh of the square [0,1]x[0,1] using meshgrid.
% Store the mesh in the matrices X and Y.
clear;
beta = 0;
Ncoarse = 31;
dx2 = 1/(Ncoarse+1)^2;
x = linspace(0,1,Ncoarse+2);
x = x(2:end-1)';
[X,Y] = meshgrid(x);

%TODO : Set up u0, v0, and initialize your multigrid
% solver.
g = @(x, y) 1*sin(4*pi*x).*sin(2*pi*y);

u0 = g(X,Y);
v0 = u0*0;
%surf(X,Y,u0)

%Close all open figure windows.
close all;
%Create a new figure window. This window will be located at the
%lower left corner of the screen and will be 800x600 pixels.
%Change here if the window doesn’t fit on the screen.

figure('Name','Waves','Position',[0 0 800 600]);

%Here we draw the initial conditions, the handle h is used to
%directly modify the plot properties. If you are curious about
%what can be changed, try "get(h)" and "set(h)".
h = surf(X,Y,u0);
%We need this to control the color-coding.
set(h,'CDataMapping','direct');
%The main for-loop, it will go on for a while. You may abort at
%any time by pressing CTRL-C.
u = u0;
v = v0;
dt = 0.001;
dt2 = dt^2;
gamma = dt2/4;
for main = 1:10000
%TODO: Solve for the next time step using your multigrid
f = dt*conv2(u, [0 1 0;1 -4 1;0 1 0]/dx2,  'same') + conv2(v, [0 1 0;1 dx2/gamma-4 1;0 1 0]*gamma/dx2,  'same');
vnew = FMGV(f, v, gamma);
u = u + dt/2*(vnew + v);
v = vnew;
% solver. Store the next time step in the matrix u.
%Controls the colors of the drawn mesh
set(h,'CData',32*u+32)
%Change the height data to be that of the new time step
set(h,'ZData',u);
%The axis normally wants to follow the data. Force it not to.
axis([0 1 0 1 -1 1]);
%Draw mesh
drawnow
end