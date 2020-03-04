close all; clear all; clc; tic;
% Objective: Segment only the borders from the image.  . 
TextSize = 16; line_width = 2; marker_size = 10;
path = 'data'; allFiles = dir(path); allNames = { allFiles.name }; 
for i = 1:size(allNames,2)-2
% for i = 4
    FileName = [path,'\',allNames{1,i+2}]; %figure; toc;
%%
    Tablet_Image = imread(FileName);  toc;
%     subplot(2,2,1); imshow(Tablet_Image); title(['(img-',num2str(i),') 'Original Image']); 
%     set(gca,'FontSize',TextSize); axis tight
%     subplot(2,2,2); imshow(rgb2gray(Tablet_Image)); title(['(img-',num2str(i),') 'RGB-->Gray Image']); 
%     set(gca,'FontSize',TextSize); axis tight
%%
    %m = 13; n = 13; % [m n] = Neighborhood size
   % Filtered_Image = median_filter(Tablet_Image, m, n); toc;
%     subplot(2,2,3); imshow(Filtered_Image); title(['(img-',num2str(i),') 'Median-filtered Image']); 
%     set(gca,'FontSize',TextSize); axis tight
%%
    m = 13; n = 13; % [m n] = Neighborhood size
    Filtered_Image = wiener_filter(Tablet_Image, m, n); toc;
%     subplot(2,2,4); imshow(Filtered_Image); title(['(img-',num2str(i),') 'Wiener-filtered Image']); 
%     set(gca,'FontSize',TextSize); axis tight
%%
    Compactness = 100; % Shape of superpixels. Higher value --> more regularly shaped, that is, a square. 
    % N = Desired number of superpixels

    if i == 1 
        N = 30; 
    elseif i == 2 
        N = 28; 
    elseif i == 3 
        N = 45; 
    elseif i == 4 
        N = 60; 
    end
%     SLIC_Image = Tablet_Image;
%     SLIC_Image = rgb2gray(Tablet_Image);
%     SLIC_Image = Filtered_Image;
    SLIC_Image = rgb2gray(Filtered_Image);
    [L,NumLabels] = superpixels(SLIC_Image,N,'Compactness',Compactness); 
    BW = boundarymask(L); No_of_SuperPixels(i) = NumLabels;
    figure; imshow(imoverlay(Tablet_Image,BW,'k'),'InitialMagnification',67);
    set(gca,'FontSize',TextSize); axis tight
    title(['(img-',num2str(i),') 2D Super-pixel based Segmentation']); 
     %figure; imshow(BW); title(['(img-',num2str(i),') Boundary of Segmentated Regions']); 
%     set(gca,'FontSize',TextSize); axis tight
%%
end
No_of_SuperPixels