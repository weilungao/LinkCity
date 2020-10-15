load city_data.mat
load city.mat
width=10e3;
theta=linspace(0, pi, 180);
r=((max(cityXY(:,1))-min(cityXY(:,1)))^2+(max(cityXY(:,2))-min(cityXY(:,2)))^2)^0.5;



if plot_N==1
    city_Plot="Beijing";
    idx = find(strcmp(cityName(:,2), city_Plot));
    number_city=city_data(idx, :);
    
    for i=1:length(number_city)
        in_city(i)=sum(number_city{i});
    end
    [max_city, idx_max]=max(in_city);
    
    scatter(cityXY(:,1), cityXY(:,2), 'bo'); hold on;
    [X, Y]=get_line(cityXY(idx,1), cityXY(idx,2), theta(idx_max), r, cityXY, width);
    fill(X,Y,'k');
    scatter(cityXY(idx,1), cityXY(idx,2), 'r*');
    scatter(cityXY(number_city{idx_max},1), cityXY(number_city{idx_max},2), 'ro');
end

if plot_N==2
    for i=1:length(cityXY)
        number_city=city_data(i, :);
        for j=1:length(number_city)
            in_city(j)=sum(number_city{j});
        end
        [max_city, idx_max]=max(in_city);
        max_number(i,1)=max_city;
        max_idx(i,1)=idx_max;
    end
    color_map=max_number;
    size_scatter=((max_number-min(max_number))/(max(max_number)-min(max_number))+0.1)*200;
    scatter(cityXY(:,1), cityXY(:,2), size_scatter,  color_map, 'fill'); hold on;
    axis equal
    axis off
    idx=find(max_number==max(max_number));
    scatter(cityXY(idx,1),cityXY(idx,2),size_scatter(idx), 'ro', 'Linewidth', 2)
    text(cityXY(idx,1),cityXY(idx,2),cityName(idx,1),'fontsize',14)
    
    figure
    histogram(max_number, [min(max_number)-0.5:1:max(max_number)+0.5]);
    xlabel('共线城市数量', 'fontsize', 14); ylabel('城市个数', 'fontsize', 14);
    
    for j=1:length(idx)
        [X, Y]=get_line(cityXY(idx(j),1), cityXY(idx(j),2), theta(max_idx(idx(j))), r, cityXY, width);
        fill(X,Y,'k','Linewidth',0.01);
    end
    
    
end



