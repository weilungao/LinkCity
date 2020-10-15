load city.mat
width=10e3;
theta=linspace(0, pi, 180);
r=((max(cityXY(:,1))-min(cityXY(:,1)))^2+(max(cityXY(:,2))-min(cityXY(:,2)))^2)^0.5;
r=10*r;
city_data=cell(length(cityXY), length(theta));
for i=1:length(cityXY)
    x=cityXY(i,1); y=cityXY(i,2);
    for j=1:length(theta)
        [city_in]=link_city(x, y, theta(j), r, cityXY, width);
        city_data{i,j}=city_in;
    end
    
    
    
end
save city_data city_data


function [city_in]=link_city(x, y, theta0, r, cityXY, width)
width=width/2;

%set( x, y ) as the origin
Xc=cityXY(:,1)-x; 
Yc=cityXY(:,2)-y; 

%get the coordinates of the sweep line
[x1, y1]=pol2cart(theta0, r);
[x2, y2]=pol2cart(theta0+pi, r);

%get the coordinates of the sweep rectangle 
[x11, y11]=pol2cart(theta0+0.5*pi, width);
[x12, y12]=pol2cart(theta0-0.5*pi, width);
[x21, y21]=pol2cart(theta0+pi+0.5*pi, width);
[x22, y22]=pol2cart(theta0+pi-0.5*pi, width);
xr1=x11+x1; yr1=y11+y1;
xr2=x12+x1; yr2=y12+y1;
xr3=x21+x2; yr3=y21+y2;
xr4=x22+x2; yr4=y22+y2;
xr=[xr1, xr2, xr3, xr4]';
yr=[yr1, yr2, yr3, yr4]';

% get the sweep rectangle:
%in case have the wrong order of the recangle points, use a  convhull
%funtion to get the sweep rectangle
K = convhull(xr,yr);

% get the cities in and on the sweep rectangle
city_in = inpolygon(Xc, Yc, xr(K), yr(K));

end



