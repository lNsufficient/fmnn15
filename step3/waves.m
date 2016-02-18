%function waves
clear;
beta = 0;

N = 31;
N = 2^8-1;
dx2 = 1/(N+1)^2;
x = linspace(0,1,N+2);
[Xp, Yp] = meshgrid(x); %To keep boundary points in the plot
x = x(2:end-1)';
[X,Y] = meshgrid(x);

a = 0.5;
b = 1;
xp = 0.9;
yp = 0.5;
xp = yp;

a = 1;
b = 100;

g = @(x, y) 1*sin(4*pi*x).*sin(2*pi*y);
g = @(x, y) a*exp(-b*((x-xp).^2+(y-yp).^2));


u0 = g(X,Y);
uP = g(Xp,Yp);
v0 = u0*0;


%Close all open figure windows.
close all;
%Create a new figure window. This window will be located at the
%lower left corner of the screen and will be 800x600 pixels.
%Change here if the window doesn’t fit on the screen.

figure('Name','Waves','Position',[0 0 800 600]);

%Here we draw the initial conditions, the handle h is used to
%directly modify the plot properties. If you are curious about
%what can be changed, try "get(h)" and "set(h)".

%h = surf(X,Y,u0);
h = surf(Xp, Yp, uP);

%We need this to control the color-coding.
set(h,'CDataMapping','direct');

%The main for-loop, it will go on for a while. You may abort at
%any time by pressing CTRL-C.
u = u0;
v = v0;
dt = 0.001;
dt2 = dt^2;
gamma = dt2/4;
zeroRow = zeros(1,length(Xp));
zeroCol = zeros(length(X),1);
tic
T = 0;
%umax = zeros(10000, 1);
for main = 1:10000
    f = dt*conv2(u, [0 1 0;1 -4 1;0 1 0]/dx2,  'same') + conv2(v, [0 1 0;1 dx2/gamma-4 1;0 1 0]*gamma/dx2,  'same');
    vnew = FMGV(f, v, gamma);
    u = u + dt/2*(vnew + v);
    v = vnew;
    umax(main) = max(max(u));
    %Controls the colors of the drawn mesh
    %set(h,'CData', 32*u+32)
    set(h,'CData',[zeroRow; zeroCol 32*u+32 zeroCol; zeroRow])
    if (~mod(main,100000))
        str = ['T = ', num2str(T), ' s'];
        annotation('textbox',[0.2 .3 .4 .5],'String',str,'FitBoxToText','on');
    end
    
    %Change the height data to be that of the new time step
    %set(h,'ZData',u);
    set(h,'ZData',[zeroRow; zeroCol u zeroCol; zeroRow]);
    %The axis normally wants to follow the data. Force it not to.
    axis([0 1 0 1 -1 1]);
    %Draw mesh
    drawnow
end
toc
str = ['T = ', num2str(T), ' s'];
    annotation('textbox',[0.2 .3 .4 .5],'String',str,'FitBoxToText','on');
