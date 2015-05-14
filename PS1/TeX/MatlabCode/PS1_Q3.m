% Computational Economics
% PS1 - Q3 Schelling's Segregation

close all
clear, clc
rng('default')

To_Plot = [15,30,45];

%% Initialization

%  0 - non-occupied
%  1 - black people
% -1 - white people
res_area = zeros(15);
res_area(randperm(225,110)) = 1;
remaining_space = find(res_area-1);
res_area(remaining_space(randperm(115,110))) = -1;
clear remaining_space
figure('name','0 Move')
imagesc(res_area), colormap(flipud(gray));
title('0 Move')
print('PS1_Q3_0Move.png','-dpng');

%% Move!

for iMove = 1:max(To_Plot)
    
    % Suround the residential area with empty houses
    full_res_area = [zeros(1,17);
        zeros(15,1), res_area, zeros(15,1);
        zeros(1,17)];
    diff_color = zeros(15);
    
    % Count if each neighbour is of different color
    for iRow = -1:1
        for iCol = -1:1
            if ~(iRow==1 && iCol==1)
                diff_color = diff_color + ...
                    (full_res_area(2+iRow:16+iRow,2+iCol:16+iCol)==-res_area);
            end
        end
    end
    
    clear full_res_area
    
    % Find empty house
    empty_house = find(res_area==0);
    diff_color(empty_house)=0;
    move = (diff_color > 8*0.35);
    empty_house = [empty_house;find(move)];
    
    count_moving_total = sum(sum(move));
    count_moving_white = sum(sum((res_area(move)==1)));
    count_moving_black = count_moving_total-count_moving_white;
    % Randomly assign house, first to black and then to white people
    move_perm = randperm(length(empty_house),count_moving_total);
    
    % Move out
    res_area(empty_house) = 0;
    % Move in
    res_area(empty_house(move_perm(1:count_moving_white))) = 1;
    res_area(empty_house(move_perm(count_moving_white+1:count_moving_total))) = -1;
    if ismember(iMove,To_Plot)
        figure('name',[num2str(iMove), ' Move'])
        imagesc(res_area), colormap(flipud(gray));
        title([num2str(iMove), ' Moves'])
        print(['PS1_Q3_',num2str(iMove),'Move.png'],'-dpng');
    end
end