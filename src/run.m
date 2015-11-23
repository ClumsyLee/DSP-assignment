load '../data/data.mat'

data2 = data;
for day = 1:size(data2, 2)-3
    row = randi([1, size(data2, 1)]);
    data2(row, day) = data2(row, day) + 20;
end
grid = interp_temp(data(:, [end end-1]), data(:, 2:end-2), 1, 3.5, 10);
grid2 = interp_temp(data2(:, [end end-1]), data2(:, 2:end-2), 1, 3.5, 10);
