close all; clear all 
clc; 


%% Step 1: Initial Allocation of Households on the Checkboard
rand('seed',0);     % initializes the random number generator
parcel = randperm(225)';
resarea = zeros(15,15);
resarea(parcel(1:110)) = 1;       % black
resarea(parcel(111:220)) = -1;    % whites
clear parcel;

resareaaug = zeros(17,17); resareaaug(2:16,2:16) = resarea;
subplot(2,2,1); 
imagesc(resareaaug);  % create a colored plot of the matrix values
colormap(flipud(gray));
title(['initial distribution']);


%% Step 2: Dynamics
racism = 0.5;
numplot = 1;
for niter = 1:45;
    mover = [];     % the matrix mover includes all indices of people that are looking for a new house
    freehouse = []; % the matrix freehouse includes all indices of ex post free houses
    for i = 2:16;
        for j = 2:16
            neighbors = resareaaug( (i-1):(i+1), (j-1):(j+1) );
            DD_white = logical(neighbors == -1);
            DD_free = logical(neighbors == 0);
            DD_black = logical(neighbors == 1);

            if resareaaug(i,j) == -1       % identify white 
                btow = (sum(DD_black(1,:)) + DD_black(2,1) + DD_black(2,3) + sum(DD_black(3,:)))/(8-sum(sum(DD_free))); %(sum(DD_white(1,:)) + DD_white(2,1) + DD_white(2,3) + sum(DD_white(3,:))); 
                if btow > racism 
                    mover = [mover; i,j,-1];
                end
            elseif resareaaug(i,j) == 1       % identify black 
                wtob = (sum(DD_white(1,:)) + DD_white(2,1) + DD_white(2,3) + sum(DD_white(3,:)))/(8-sum(sum(DD_free))); %(sum(DD_black(1,:)) + DD_black(2,1) + DD_black(2,3) + sum(DD_black(3,:))); 
                if wtob > racism 
                    mover = [mover; i,j,1];
                end
            elseif resareaaug(i,j) == 0     % identify non-occupied houses
                freehouse = [freehouse; i,j,0];
            end
        end
    end
    freehouse = [freehouse; mover];     % free houses is previously free and just becoming free
    
    nrow_mover = length(mover);
    nrow_freehouse = length(freehouse);
    parcel = randperm(nrow_freehouse)';     % prepare random allocation of movers to free houses by randomizing houses
    for k = 1:nrow_freehouse;
        if k <= nrow_mover
            resareaaug(freehouse(parcel(k),1),freehouse(parcel(k),2)) = mover(k,3);
        else
            resareaaug(freehouse(parcel(k),1),freehouse(parcel(k),2)) = 0;
        end
    end
    clear parcel;
    
    if rem(niter,15) == 0
        numplot = numplot+1;
        subplot(2,2,numplot);         
        imagesc(resareaaug);
        colormap(flipud(gray));
        title(['iteration ', num2str(niter)]);
    end
    %fprintf('iter = %.3d\n',niter);
end
