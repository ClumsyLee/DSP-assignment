load '../data/data.mat'

grid = interp_temp(data(:, [end end-1]), data(:, 2:end-2), 10, 3.5, 10);
