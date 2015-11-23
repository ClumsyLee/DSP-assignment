function temp_grid = interp_temp(pos, temp, interval, alpha, desired_stations)
    len = size(pos, 1);

    min_xy = min(pos);
    max_xy = max(pos);

    grid_size = fliplr(ceil((max_xy - min_xy) / interval) + [1 1]);
    w_mat = zeros(prod(grid_size), len);

    % Calculate weight matrix.
    k = 1;
    for kx = 1:grid_size(2)
        x = min_xy(1) + interval * (kx - 1);
        for ky = 1:grid_size(1)
            y = min_xy(2) + interval * (ky - 1);

            w_mat(k, :) = weight(pos, temp, [x y], alpha, desired_stations)';
            w_mat(k, :) = w_mat(k, :) / sum(w_mat(k, :));  % Normalize.
            k = k + 1;
        end
    end

    days = size(temp, 2);
    temp_grid = zeros([grid_size days]);

    for day = 1:days
        temp_grid(:, :, day) = reshape(w_mat * temp(:, day), grid_size);
    end
end

function w = weight(pos, temp, pred_pos, alpha, desired_stations)
    len = size(pos, 1);
    w = zeros(len, 1);

    r = zeros(len, 1);
    for k = 1:len
        r(k) = cal_dis(pos(k, :), pred_pos);
    end

    [value, index] = sort(r);
    non_zeros = index(1:desired_stations);
    rp = value(desired_stations);

    w(non_zeros) = exp(-(r(non_zeros) / rp).^2 * alpha) - exp(-alpha);
end
