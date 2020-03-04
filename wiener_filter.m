function Filtered_Image = wiener_filter(Input_Image, m, n)
    % I = input image
    % [m n] = Neighborhood size
    for c = 1 : 3
        Input_Image(:, :, c) = wiener2(Input_Image(:, :, c), [m, n]);
%         Input_Image(:, :, c) = imfill(Input_Image(:, :, c),'holes');
        Input_Image(:, :, c) = imfill(Input_Image(:, :, c));
    end
    Filtered_Image = Input_Image;
end